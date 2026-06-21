import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:ConnectUs/pages/chat/chat_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/components/contact_tile.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:ConnectUs/models/contact.dart' as HiveContact;
import 'package:ConnectUs/models/chat.dart';
import 'package:ConnectUs/services/chat_sync_service.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktop => kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  Box<HiveContact.Contact>? contactBox;
  List<Contact> _contacts = [];
  // Replace LinkedHashSet with a List + proper sort
  final List<Chats> _chats = [];

  void updateChatPreview(String contactName, String lastMessage, DateTime time, {String? supabaseUsername, String? roomId}) {
    setState(() {
      final existingIndex = _chats.indexWhere((c) => c.contactName == contactName);
      if (existingIndex >= 0) {
        // Update existing chat
        _chats[existingIndex].lastMessage = lastMessage;
        _chats[existingIndex].lastMessageTime = time;
        if (supabaseUsername != null) _chats[existingIndex].supabaseUsername = supabaseUsername;
        if (roomId != null) _chats[existingIndex].roomId = roomId;
      } else {
        // Create new chat entry
        _chats.add(Chats(
          contactName: contactName,
          supabaseUsername: supabaseUsername,
          roomId: roomId,
          lastMessage: lastMessage,
          lastMessageTime: time,
        ));
      }
      // Sort: most recent first
      _chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    });
  }

  bool _isLoading = false;
  List<Contact> _registeredContacts = [];
  List<Contact> _nonRegisteredContacts = [];
  Map<String, String> _phoneToUsername = {};
  Timer? _debounceTimer;
  StreamSubscription? _syncSubscription;
  String? _myUsername;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeHive();
    _loadContacts();
    _initSyncListener();
  }

  Future<void> _initSyncListener() async {
    // Get my username for room ID matching
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await Supabase.instance.client
          .from('users')
          .select('usrname')
          .eq('id', user.id)
          .maybeSingle();
      _myUsername = data?['usrname'];
    }

    _syncSubscription = ChatSyncService().messageStream.listen((event) {
      final roomId = event['room_id'] as String;
      final messages = event['messages'] as List;
      if (messages.isEmpty || _myUsername == null) return;

      final otherUser = ChatSyncService().getOtherUserFromRoomId(roomId);
      final lastMsg = messages.last as Map;
      final content = lastMsg['content'] ?? '';
      final time = DateTime.tryParse(lastMsg['createdAt'] ?? '') ?? DateTime.now();

      // Find or create chat tile
      setState(() {
        final idx = _chats.indexWhere((c) => c.supabaseUsername == otherUser || c.roomId == roomId);
        if (idx >= 0) {
          _chats[idx].lastMessage = content;
          _chats[idx].lastMessageTime = time;
          _chats[idx].roomId = roomId;
          if (event['type'] == 'catchup') {
            _chats[idx].unreadCount += (event['new_count'] as int? ?? 0);
          }
        } else {
          // Create tile if missing (e.g., first message from new contact)
          _chats.add(Chats(
            contactName: otherUser,
            supabaseUsername: otherUser,
            roomId: roomId,
            lastMessage: content,
            lastMessageTime: time,
            unreadCount: event['type'] == 'catchup' ? (event['new_count'] as int? ?? 1) : 1,
          ));
        }
        _chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      });
    });
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

  Future<Map<String, String>> _fetchRegisteredUsers() async {
    try {
      final response = await Supabase.instance.client.from('users').select('phone_number, usrname');
      final Map<String, String> phoneToUsername = {};
      for (final row in response as List) {
        final phone = _normalizePhoneNumber(row['phone_number'] as String? ?? '');
        final username = row['usrname'] as String? ?? '';
        if (phone.isNotEmpty && username.isNotEmpty) {
          phoneToUsername[phone] = username;
        }
      }
      return phoneToUsername;
    } catch (e) {
      debugPrint('Error fetching registered users: $e');
      return {};
    }
  }

  Future<void> _categorizeContacts() async {
    _phoneToUsername = await _fetchRegisteredUsers();
    final registeredNumbers = _phoneToUsername.keys.toSet();
    _registeredContacts = [];
    _nonRegisteredContacts = [];
    for (final contact in _contacts) {
      bool isRegistered = false;
      for (final phone in contact.phones) {
        final normalized = _normalizePhoneNumber(phone.number);
        if (registeredNumbers.contains(normalized)) {
          isRegistered = true;
          break;
        }
      }
      if (isRegistered) {
        _registeredContacts.add(contact);
      } else {
        _nonRegisteredContacts.add(contact);
      }
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
  
  void _createChatWithContact(Contact contact) {
    String? supabaseUsername;
    for (final phone in contact.phones) {
      final normalized = _normalizePhoneNumber(phone.number);
      supabaseUsername = _phoneToUsername[normalized];
      if (supabaseUsername != null) break;
    }

    final roomId = _getRoomId(_myUsername ?? 'me', supabaseUsername ?? contact.displayName);

    updateChatPreview(
      contact.displayName,
      'Click here to start chatting',
      DateTime.now(),
      supabaseUsername: supabaseUsername,
      roomId: roomId,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatArea(
        userName: contact.displayName,
        supabaseUsername: supabaseUsername,
        onMessageSent: (lastMsg, time) => updateChatPreview(contact.displayName, lastMsg, time),
      )),
    );
  }

  String _getRoomId(String userA, String userB) {
    final users = [userA, userB]..sort();
    return users.join('_');
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
    _debounceTimer?.cancel();
    _searchController.dispose();
    _syncSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final displayChats = List<Chats>.from(_chats);

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
                                    MaterialPageRoute(builder: (context) => ChatArea(
                                      userName: chat.contactName,
                                      supabaseUsername: chat.supabaseUsername,
                                      onMessageSent: (lastMsg, time) => updateChatPreview(chat.contactName, lastMsg, time),
                                    ))
                                  );
                                },
                                child: ContactTile(
                                  contactName: chat.contactName,
                                  lastMessage: chat.lastMessage,
                                  unreadCount: chat.unreadCount,
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