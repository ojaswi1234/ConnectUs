import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:ConnectUs/pages/chat/chatArea.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/components/contactTile.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:ConnectUs/models/contact.dart' as HiveContact;
// --- FERRY IMPORTS ---
import 'package:provider/provider.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  String? _myUsername;

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktop =>
      kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  Box<HiveContact.Contact>? contactBox;
  
  // Note: We no longer need _chats list because Ferry handles the state
  bool _isLoading = false;
  List<Contact> _contacts = []; // Kept for contact book logic
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
    _loadMyProfile();
  }

  Future<void> _loadMyProfile() async {
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
      }
    }
  }

  void _initializeHive() {
    try {
      contactBox = Hive.box<HiveContact.Contact>('contacts');
    } catch (e) {
      debugPrint('Error accessing Hive box: $e');
    }
  }

  Future<void> _loadContacts() async {
    if (contactBox != null && contactBox!.isNotEmpty) {
      final hiveContacts = contactBox!.values.toList();
      _contacts = hiveContacts.map((hiveContact) {
        final contact = Contact();
        final contactName =
            hiveContact.name.isNotEmpty ? hiveContact.name : 'Unknown Contact';
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
    if (_cachedRegisteredNumbers != null) return _cachedRegisteredNumbers!;
    try {
      final response =
          await Supabase.instance.client.from('users').select('phone_number');
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
            (normalized.length > 2 &&
                registeredNumbers.contains(normalized.substring(2)))) {
          isRegistered = true;
          break;
        }
      }
      if (isRegistered)
        _registeredContacts.add(contact);
      else
        _nonRegisteredContacts.add(contact);
    }
  }

  String _normalizePhoneNumber(String phoneNumber) {
    String normalized = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (normalized.startsWith('0')) normalized = normalized.substring(1);
    if (normalized.startsWith('91') && normalized.length == 12)
      return normalized.substring(2);
    return normalized;
  }

  Future<void> _fetchContactsFromDevice() async {
    if (isMobile) {
      if (!await FlutterContacts.requestPermission()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Permission denied to access contacts.')));
        return;
      }
      setState(() {
        _isLoading = true;
        _registeredContacts = [];
      });
      try {
        final contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: false);
        if (contactBox != null) {
          await contactBox!.clear();
          for (final contact in contacts) {
            final hiveContact = HiveContact.Contact(
              name: contact.displayName.isNotEmpty
                  ? contact.displayName
                  : 'Unknown Contact',
              phoneNumber:
                  contact.phones.isNotEmpty ? contact.phones.first.number : '',
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

  void _createChatWithContact(Contact contact) {
    // Navigate directly. Use the chatArea to create the room implicitly.
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatArea(userName: contact.displayName)),
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
    // Ferry handles refresh via cache/network policy automatically
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // If we haven't loaded the username yet, show nothing or a loader
    if (_myUsername == null) {
      return Container(color: const Color(0xFF1E1E1E));
    }

    return Container(
      color: const Color(0xFF1E1E1E),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    style: const TextStyle(color: AppTheme.accent),
                    cursorColor: AppTheme.accent,
                    onChanged: (_) => _onSearchChanged(),
                    decoration: InputDecoration(
                      hintText: 'Search Name/Number.....',
                      hintStyle: const TextStyle(color: AppTheme.accent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon:
                          const Icon(Icons.search, color: AppTheme.accentDark),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 41, 41, 41),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
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
                    // --- CHANGED: Using Operation to fetch from Hive/Server ---
                    child: Operation(
                      client: Provider.of<Client>(context),
                      // Query the View we created to get recent chats
                      operationRequest: GGetMyChatsReq((b) => b
                        ..fetchPolicy = FetchPolicy.CacheAndNetwork),
                      builder: (context, response, error) {
                        // 1. Loading State (only if no data)
                        if (response?.loading == true &&
                            response?.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // 2. Data State
                        var chats =
                            response?.data?.user_chats_view.toList() ?? [];

                        // 3. Search Filter Logic
                        final searchText =
                            _searchController.text.trim().toLowerCase();
                        if (searchText.isNotEmpty) {
                          chats = chats
                              .where((c) => c.contact_name
                                  .toLowerCase()
                                  .contains(searchText))
                              .toList();
                        }

                        // 4. Empty State
                        if (chats.isEmpty) {
                          return ListView(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3),
                              Center(
                                child: Text(
                                  'No chats available. Start a new chat!',
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        }

                        // 5. Render List
                        return ListView.builder(
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatArea(
                                            userName: chat.contact_name)));
                              },
                              child: ContactTile(
                                contactName: chat.contact_name,
                                lastMessage: chat.last_message,
                                unreadCount: 0, // Implement read receipts later
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // ---------------------------------------------------------
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
                  shape: const CircleBorder(
                      side: BorderSide(color: AppTheme.accentDark)),
                  child: const Icon(Icons.assistant,
                      size: 20, color: AppTheme.accent),
                ),
                const SizedBox(height: 14),
                FloatingActionButton(
                  shape: const CircleBorder(
                      side: BorderSide(color: AppTheme.accentDark)),
                  onPressed: _showContactFlowDialog,
                  backgroundColor: AppTheme.accent,
                  child: const Icon(Icons.chat_bubble_outline_rounded,
                      color: Color(0xFF1E1E1E), size: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}