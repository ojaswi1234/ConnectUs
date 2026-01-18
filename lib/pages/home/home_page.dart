import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:ConnectUs/pages/chat/chatArea.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/components/contactTile.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:ConnectUs/models/contact.dart' as HiveContact;

// NEW IMPORTS FOR FERRY
import 'package:provider/provider.dart';
import 'package:ferry/ferry.dart';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  
  // Stores the currently logged-in user's username
  String? _myUsername; 
  // Listens for incoming messages globally
  StreamSubscription? _incomingMessageSub; 

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktop => kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  Box<HiveContact.Contact>? contactBox;
  List<Contact> _contacts = [];
  // Using LinkedHashSet to keep unique chats
  final LinkedHashSet<Chats> _chats = LinkedHashSet<Chats>();

  bool _isLoading = false;
  List<Contact> _registeredContacts = [];
  List<Contact> _nonRegisteredContacts = [];
  Set<String>? _cachedRegisteredNumbers;
  Timer? _debounceTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeHive();
    _loadContacts();
    _loadMyProfileAndListen(); // Start the listener
  }

  // NEW: Fetch profile and start listening for messages
  Future<void> _loadMyProfileAndListen() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await Supabase.instance.client
          .from('users')
          .select('usrname')
          .eq('id', user.id)
          .maybeSingle();
      
      if (mounted && data != null) {
        setState(() {
          _myUsername = data['usrname'];
        });
        _startGlobalListener();
      }
    }
  }

  // NEW: The "Auto-Refresh" Logic
  void _startGlobalListener() {
    if (_myUsername == null) return;
    
    // We access the Client provided in main.dart
    // Note: ensure main.dart wraps the app in a Provider<Client>
    final client = Provider.of<Client>(context, listen: false);

    final listenReq = GListenToIncomingMessagesReq((b) => b
      ..vars.user = _myUsername!
    );

    _incomingMessageSub = client.request(listenReq).listen((response) {
      if (response.data?.messageSentToUser != null) {
        final msg = response.data!.messageSentToUser;
        
        // When a message arrives, we automatically add/update the chat tile
        setState(() {
          // Remove if exists to re-add at top (simple LRU behavior)
          final tempChat = Chats(contactName: msg.user, lastMessage: msg.content);
          _chats.remove(tempChat); 
          _chats.add(tempChat);
        });
      }
    });
  }

  void _initializeHive() {
    try {
      contactBox = Hive.box<HiveContact.Contact>('contacts');
    } catch (e) {
      debugPrint('Error accessing Hive box: $e');
    }
  }

  // ... (Keep _loadContacts, _fetchRegisteredPhoneNumbers, _categorizeContacts, 
  //      _normalizePhoneNumber, _fetchContactsFromDevice as they were) ...
  
  Future<void> _loadContacts() async {
    if (contactBox != null && contactBox!.isNotEmpty) {
      final hiveContacts = contactBox!.values.toList();
      _contacts = hiveContacts.map((hiveContact) {
        final contact = Contact();
        final contactName = hiveContact.name.isNotEmpty ? hiveContact.name : 'Unknown Contact';
        contact.name.first = contactName;
        contact.displayName = contactName;
        contact.phones = [Phone(hiveContact.phoneNumber)];
        return contact;
      }).toList();

      setState(() => _isLoading = false);
      await _categorizeContacts();
      return;
    }
    await _fetchContactsFromDevice();
  }

  Future<Set<String>> _fetchRegisteredPhoneNumbers() async {
     // ... (Existing implementation) ...
     if (_cachedRegisteredNumbers != null) return _cachedRegisteredNumbers!;
    try {
      final response = await Supabase.instance.client.from('users').select('phone_number');
      final phoneNumbers = (response as List)
          .map((row) => row['phone_number'] as String)
          .where((number) => number.isNotEmpty)
          .map((number) => _normalizePhoneNumber(number))
          .where((number) => number.isNotEmpty)
          .toSet();
      _cachedRegisteredNumbers = phoneNumbers;
      return phoneNumbers;
    } catch (e) {
      debugPrint('Error fetching registered phone numbers: $e');
      return <String>{};
    }
  }
  
  Future<void> _categorizeContacts() async {
    final registeredNumbers = await _fetchRegisteredPhoneNumbers();
    _registeredContacts = [];
    _nonRegisteredContacts = [];
    for (final contact in _contacts) {
      bool isRegistered = false;
      for (final phone in contact.phones) {
        final normalized = _normalizePhoneNumber(phone.number);
        if (registeredNumbers.contains(normalized) ||
            registeredNumbers.contains('91$normalized') ||
            (normalized.length > 2 && registeredNumbers.contains(normalized.substring(2)))) {
          isRegistered = true;
          break;
        }
      }
      if (isRegistered) _registeredContacts.add(contact);
      else _nonRegisteredContacts.add(contact);
    }
  }

  String _normalizePhoneNumber(String phoneNumber) {
    String normalized = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (normalized.startsWith('0')) normalized = normalized.substring(1);
    if (normalized.startsWith('91') && normalized.length == 12) return normalized.substring(2);
    return normalized;
  }

  Future<void> _fetchContactsFromDevice() async {
    if (isMobile) {
      if (!await FlutterContacts.requestPermission()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permission denied to access contacts.')));
        return;
      }
      setState(() { _isLoading = true; _registeredContacts = []; });
      try {
        final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
        if (contactBox != null) {
          await contactBox!.clear();
          for (final contact in contacts) {
            final hiveContact = HiveContact.Contact(
              name: contact.displayName.isNotEmpty ? contact.displayName : 'Unknown Contact',
              phoneNumber: contact.phones.isNotEmpty ? contact.phones.first.number : '',
            );
            await contactBox!.add(hiveContact);
          }
        }
        _contacts = contacts;
        await _categorizeContacts();
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
  
  // ... (End of existing helpers) ...

  void _createChatWithContact(Contact contact) {
    setState(() {
      // Logic to add manually started chats
      // We remove first to ensure we don't have duplicates and it moves to top if using list logic
      final chat = Chats(contactName: contact.displayName, lastMessage: 'Click here to start chatting');
      _chats.add(chat);
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatArea(userName: contact.displayName)),
    );
  }

  void _inviteContact(Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invite ${contact.displayName} to ConnectUs')),
    );
  }

  void _showContactFlowDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsPage(
          registeredContacts: _registeredContacts,
          nonRegisteredContacts: _nonRegisteredContacts,
          onContactTap: _createChatWithContact,
          onInviteContact: _inviteContact,
          isLoading: _isLoading,
        ),
      ),
    );
  }

  Future<void> _refreshChatList() async {
    // Logic to reload chats from backend could go here if you had a Persistent Store API
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _incomingMessageSub?.cancel(); // Cancel listener
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Reversed to show newest at top if we appended to end of list
    final displayChats = _chats.toList().reversed.toList();

    return Container(
      color: const Color(0xFF1E1E1E),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    style: const TextStyle(color: AppTheme.accent),
                    cursorColor: AppTheme.accent,
                    onChanged: (_) => _onSearchChanged(),
                    decoration: InputDecoration(
                      hintText: 'Search Name/Number.....',
                      hintStyle: const TextStyle(color: AppTheme.accent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.accentDark),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 41, 41, 41),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    controller: _searchController,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RefreshIndicator(
                    onRefresh: _refreshChatList,
                    child: displayChats.isNotEmpty
                        ? ListView.builder(
                            itemCount: displayChats.length,
                            itemBuilder: (context, index) {
                              final chat = displayChats[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => ChatArea(userName: chat.contactName))
                                  );
                                },
                                child: ContactTile(
                                  contactName: chat.contactName,
                                  lastMessage: chat.lastMessage,
                                  unreadCount: 0,
                                ),
                              );
                            },
                          )
                        : ListView(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                              Center(
                                child: Text(
                                  'No chats available. Start a new chat!',
                                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pushNamed(context, '/ai'),
                  padding: const EdgeInsets.all(18),
                  shape: const CircleBorder(side: BorderSide(color: AppTheme.accentDark)),
                  child: const Icon(Icons.assistant, size: 20, color: AppTheme.accent),
                ),
                const SizedBox(height: 14),
                FloatingActionButton(
                  shape: const CircleBorder(side: BorderSide(color: AppTheme.accentDark)),
                  onPressed: _showContactFlowDialog,
                  backgroundColor: AppTheme.accent,
                  child: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF1E1E1E), size: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Chats {
  final String contactName;
  final String lastMessage;

  Chats({required this.contactName, required this.lastMessage});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chats &&
          runtimeType == other.runtimeType &&
          contactName == other.contactName;

  @override
  int get hashCode => contactName.hashCode;
}