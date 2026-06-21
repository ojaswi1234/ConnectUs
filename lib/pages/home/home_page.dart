import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/pages/chat/chat_area.dart';
import 'package:ConnectUs/pages/config/settings.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/models/contact.dart' as HiveContact;
import 'package:ConnectUs/models/chat.dart';
import 'package:ConnectUs/pages/home/status.dart';
import 'package:ConnectUs/pages/chat/contact_selection_page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  Box? contactBox;
  List<Contact> _contacts = [];
  final List<Chats> _chats = [];
  String? _myUsername;
  bool _isLoading = false;
  List<Contact> _registeredContacts = [];
  List<Contact> _nonRegisteredContacts = [];
  Map<String, String> _phoneToUsername = {};
  Timer? _debounceTimer;
  
  int _selectedNavIndex = 3; // 3 = Chat tab default
  int _selectedTabFilter = 0; // 0=All, 1=Personal, 2=Work

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeHive();
    _loadContacts();
    _loadMyUsername();
  }

  Future<void> _loadMyUsername() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await Supabase.instance.client.from('users').select('usrname').eq('id', user.id).maybeSingle();
      _myUsername = data?['usrname'];
    }
  }

  void _initializeHive() {
    try { contactBox = Hive.box('contacts'); } catch (e) { debugPrint('Hive error: $e'); }
  }

  Future<void> _loadContacts() async {
    if (contactBox != null && contactBox!.isNotEmpty) {
      final hiveContacts = contactBox!.values.toList();
      _contacts = hiveContacts.map((hc) {
        final c = Contact();
        c.name.first = hc.name;
        c.displayName = hc.name;
        c.phones = [Phone(hc.phoneNumber)];
        return c;
      }).toList();
      await _categorizeContacts();
      return;
    }
    await _fetchContactsFromDevice();
  }

  Future<Map<String, String>> _fetchRegisteredUsers() async {
    try {
      final response = await Supabase.instance.client.from('users').select('phone_number, usrname');
      final Map<String, String> map = {};
      for (final row in response) {
        final phone = _normalizePhone(row['phone_number'] ?? '');
        final username = row['usrname'] ?? '';
        if (phone.isNotEmpty && username.isNotEmpty) map[phone] = username;
      }
      return map;
    } catch (e) { return {}; }
  }

  Future<void> _categorizeContacts() async {
    _phoneToUsername = await _fetchRegisteredUsers();
    final registeredNumbers = _phoneToUsername.keys.toSet();
    _registeredContacts = [];
    _nonRegisteredContacts = [];
    for (final c in _contacts) {
      bool isReg = false;
      for (final p in c.phones) {
        if (registeredNumbers.contains(_normalizePhone(p.number))) { isReg = true; break; }
      }
      if (isReg) _registeredContacts.add(c); else _nonRegisteredContacts.add(c);
    }
    if (mounted) setState(() {});
  }

  String _normalizePhone(String phone) {
    String n = phone.replaceAll(RegExp(r'\D'), '');
    if (n.startsWith('0')) n = n.substring(1);
    if (n.startsWith('91') && n.length == 12) n = n.substring(2);
    return n;
  }

  Future<void> _fetchContactsFromDevice() async {
    if (!isMobile) return;
    if (!await FlutterContacts.requestPermission()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
      if (contactBox != null) {
        await contactBox!.clear();
        for (final c in contacts) {
          await contactBox!.add(HiveContact.Contact(name: c.displayName, phoneNumber: c.phones.isNotEmpty ? c.phones.first.number : ''));
        }
      }
      _contacts = contacts;
      await _categorizeContacts();
    } finally { setState(() => _isLoading = false); }
  }

  void _createChatWithContact(Contact contact) {
    String? supabaseUsername;
    for (final p in contact.phones) {
      final n = _normalizePhone(p.number);
      if (_phoneToUsername.containsKey(n)) { supabaseUsername = _phoneToUsername[n]; break; }
    }
    final roomId = _getRoomId(_myUsername ?? 'me', supabaseUsername ?? contact.displayName);
    _updateChatPreview(contact.displayName, 'Start a conversation...', DateTime.now(), supabaseUsername: supabaseUsername, roomId: roomId);
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatArea(
      userName: contact.displayName,
      supabaseUsername: supabaseUsername,
      onMessageSent: (msg, time) => _updateChatPreview(contact.displayName, msg, time),
    )));
  }

  String _getRoomId(String a, String b) {
    final u = [a, b]..sort();
    return u.join('_');
  }

  void _updateChatPreview(String name, String last, DateTime time, {String? supabaseUsername, String? roomId}) {
    setState(() {
      final idx = _chats.indexWhere((c) => c.contactName == name);
      if (idx >= 0) {
        _chats[idx].lastMessage = last;
        _chats[idx].lastMessageTime = time;
        if (supabaseUsername != null) _chats[idx].supabaseUsername = supabaseUsername;
        if (roomId != null) _chats[idx].roomId = roomId;
      } else {
        _chats.add(Chats(contactName: name, supabaseUsername: supabaseUsername, roomId: roomId, lastMessage: last, lastMessageTime: time));
      }
      _chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    });
  }

  void _showContactFlow() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ContactsPage(
      registeredContacts: _registeredContacts,
      nonRegisteredContacts: _nonRegisteredContacts,
      onContactTap: _createChatWithContact,
      onInviteContact: (c) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invite ${c.displayName}'))),
      isLoading: _isLoading,
    )));
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () => setState(() {}));
  }

  Future<void> _openingCamera() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (!mounted) return;
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
      if (!mounted) return;
      if (_imageFile != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.file(_imageFile!, height: 200),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text('Retake'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _openingCamera();
                          },
                        ),
                        TextButton(
                          child: const Text('Use Photo'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactSelectionPage(imageFile: _imageFile!),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Camera Not Supported'),
          content: const Text('Camera functionality is only available on mobile devices.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildBodyContent() {
    if (_selectedNavIndex == 0) {
      return const Center(child: Text("Call History (Coming Soon)", style: TextStyle(color: AppTheme.textMuted)));
    } else if (_selectedNavIndex == 1) {
      return const Status();
    } else {
      // 3 = Chat
      return _buildChatsContent();
    }
  }

  Widget _buildChatsContent() {
    final displayChats = _chats.where((c) {
      final matchesSearch = _searchController.text.isEmpty || c.contactName.toLowerCase().contains(_searchController.text.toLowerCase());
      
      // Dummy logic for tabs: 
      // 1 = Personal (only showing contacts that contain vowels for demo)
      // 2 = Work (only showing contacts without vowels or maybe just empty for demo)
      bool matchesTab = true;
      if (_selectedTabFilter == 1) {
        matchesTab = c.contactName.toLowerCase().contains(RegExp(r'[aeiou]'));
      } else if (_selectedTabFilter == 2) {
        matchesTab = !c.contactName.toLowerCase().contains(RegExp(r'[aeiou]'));
      }

      return matchesSearch && matchesTab;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Chats', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              Row(
                children: [
                  GestureDetector(
                    onTap: _openingCamera,
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                      child: const Icon(Icons.camera_alt_outlined, color: AppTheme.textDark),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Toggle search bar
                      if (_searchController.text.isNotEmpty) {
                        _searchController.clear();
                        _onSearchChanged();
                      } else {
                        // Focus could be requested here
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                      child: const Icon(Icons.search, color: AppTheme.textDark),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_searchController.text.isNotEmpty || true) // Show search bar if you want
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _onSearchChanged(),
              decoration: InputDecoration(
                hintText: 'Search chats...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                filled: true,
                fillColor: AppTheme.surface,
              ),
            ),
          ),
        const SizedBox(height: 8),
        // Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedTabFilter = 0),
                child: _TabPill(label: 'All', active: _selectedTabFilter == 0),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => _selectedTabFilter = 1),
                child: _TabPill(label: 'Personal', active: _selectedTabFilter == 1),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => _selectedTabFilter = 2),
                child: _TabPill(label: 'Work', active: _selectedTabFilter == 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Chat List
        Expanded(
          child: displayChats.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: displayChats.length,
                  itemBuilder: (context, index) {
                    final chat = displayChats[index];
                    return _ChatTile(
                      chat: chat,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatArea(
                        userName: chat.contactName,
                        supabaseUsername: chat.supabaseUsername,
                        onMessageSent: (msg, time) => _updateChatPreview(chat.contactName, msg, time),
                      ))),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 64, color: AppTheme.textMuted.withOpacity(0.3)),
                      const SizedBox(height: 16),
                      Text('No conversations found', style: TextStyle(color: AppTheme.textMuted.withOpacity(0.5), fontSize: 16)),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 100), // Space for bottom nav
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);

    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBodyContent(),
             
            // Floating Bottom Nav
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Container(
                height: 70,
                decoration: AppTheme.pillDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavIcon(icon: Icons.call_outlined, index: 0, selected: _selectedNavIndex, onTap: (i) => setState(() => _selectedNavIndex = i)),
                    _NavIcon(icon: Icons.person_outline, index: 1, selected: _selectedNavIndex, onTap: (i) => setState(() => _selectedNavIndex = i)),
                    // Center FAB
                    GestureDetector(
                      onTap: _showContactFlow,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: AppTheme.coralGradient,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: AppTheme.coral.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 8))],
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 28),
                      ),
                    ),
                    _NavIcon(icon: Icons.chat_bubble, index: 3, selected: _selectedNavIndex, onTap: (i) => setState(() => _selectedNavIndex = i)),
                    _NavIcon(icon: Icons.settings_outlined, index: 4, selected: _selectedNavIndex, onTap: (i) {
                      setState(() => _selectedNavIndex = i); // UI update to highlight
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())).then((_) {
                        setState(() => _selectedNavIndex = 3); // revert when returning
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool active;
  const _TabPill({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: active ? AppTheme.coralGradient : null,
        color: active ? null : AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: active ? [BoxShadow(color: AppTheme.coral.withOpacity(0.3), blurRadius: 12)] : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : AppTheme.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final Chats chat;
  final VoidCallback onTap;
  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final timeString = _formatTime(chat.lastMessageTime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardShadow,
          child: Row(
            children: [
              // Avatar with cyan ring
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.cyanRingGradient,
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.bgCool,
                  child: Text(
                    chat.contactName.isNotEmpty ? chat.contactName[0].toUpperCase() : '?',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(chat.contactName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                        ),
                        Text(timeString, style: TextStyle(fontSize: 12, color: AppTheme.textMuted.withOpacity(0.7))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      chat.lastMessage,
                      style: TextStyle(fontSize: 14, color: AppTheme.textMuted.withOpacity(0.8)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (chat.unreadCount > 0)
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(gradient: AppTheme.coralGradient, borderRadius: BorderRadius.circular(20)),
                  child: Text('${chat.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime t) {
    final now = DateTime.now();
    if (t.day == now.day && t.month == now.month && t.year == now.year) {
      return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    }
    return '${t.day}/${t.month}';
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selected;
  final Function(int) onTap;
  const _NavIcon({required this.icon, required this.index, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? AppTheme.logoCyan : Colors.white.withOpacity(0.5),
          size: 26,
        ),
      ),
    );
  }
}