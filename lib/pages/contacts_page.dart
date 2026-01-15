import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart'; //

class ContactsPage extends StatefulWidget {
  final List<Contact> registeredContacts;
  final List<Contact> nonRegisteredContacts;
  final Function(Contact) onContactTap;
  final Function(Contact) onInviteContact;
  final bool isLoading;

  const ContactsPage({
    super.key,
    this.registeredContacts = const [],
    this.nonRegisteredContacts = const [],
    required this.onContactTap,
    required this.onInviteContact,
    this.isLoading = false,
  });

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredRegistered = [];
  List<Contact> _filteredNonRegistered = [];

  // Web-specific state
  List<Contact> _webSearchResults = [];
  bool _isWebSearching = false;
  Timer? _debounceTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _filteredRegistered = widget.registeredContacts;
    _filteredNonRegistered = widget.nonRegisteredContacts;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  void _filterContacts(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        if (isMobile) {
          // Mobile Logic: Filter local device contacts
          setState(() {
            if (query.isEmpty) {
              _filteredRegistered = widget.registeredContacts;
              _filteredNonRegistered = widget.nonRegisteredContacts;
            } else {
              final lowerQuery = query.toLowerCase();
              _filteredRegistered = widget.registeredContacts
                  .where(
                      (c) => c.displayName.toLowerCase().contains(lowerQuery))
                  .toList();
              _filteredNonRegistered = widget.nonRegisteredContacts
                  .where(
                      (c) => c.displayName.toLowerCase().contains(lowerQuery))
                  .toList();
            }
          });
        } else {
          // Web Logic: Search Supabase via 'usrname'
          _searchUsersOnWeb(query);
        }
      }
    });
  }

  Future<void> _searchUsersOnWeb(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _webSearchResults = [];
        _isWebSearching = false;
      });
      return;
    }

    setState(() => _isWebSearching = true);

    try {
      // Querying the 'usrname' column specifically
      final List<dynamic> response = await Supabase.instance.client
          .from('users')
          .select('usrname, phone_number')
          .ilike('usrname', '%$query%')
          .limit(20);

      final results = response.map((userData) {
        final contact = Contact();
        // Explicitly map 'usrname' to displayName
        contact.displayName = userData['usrname'] ?? 'Unknown User';
        if (userData['phone_number'] != null) {
          contact.phones = [Phone(userData['phone_number'].toString())];
        }
        return contact;
      }).toList();

      if (mounted) {
        setState(() {
          _webSearchResults = results;
          _isWebSearching = false;
        });
      }
    } catch (e) {
      debugPrint('Web search failed: $e');
      if (mounted) setState(() => _isWebSearching = false);
    }
  }

  Widget _buildContactTile(Contact contact, bool isRegistered) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: isRegistered
            ? AppTheme.accentDark.withOpacity(0.08)
            : AppTheme.accent.withOpacity(0.04),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isRegistered ? Colors.green : AppTheme.accentDark,
            child: Text(
              contact.displayName.isNotEmpty
                  ? contact.displayName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            contact.displayName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          subtitle: contact.phones.isNotEmpty
              ? Text(isMobile ? contact.phones.first.number : "",
                  style: const TextStyle(color: Colors.white70))
              : null,
          trailing: Icon(
            isRegistered ? Icons.chat_bubble : Icons.person_add,
            color: isRegistered ? Colors.green : AppTheme.accentDark,
          ),
          onTap: () {
            if (isRegistered || !isMobile) {
              Navigator.pop(context);
              widget.onContactTap(contact); // Triggers chat initiation
            } else {
              widget.onInviteContact(contact);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title:
            const Text('Select Contact', style: TextStyle(color: Colors.black)),
        backgroundColor: AppTheme.accentDark,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: isMobile ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText:
                    isMobile ? 'Search contacts...' : 'Search via UserName',
                prefixIcon: Icon(Icons.search,
                    color: isMobile ? Colors.grey : Colors.black),
                filled: true,
                fillColor:
                    isMobile ? Colors.grey.shade800 : AppTheme.accentDark,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
              onChanged: _filterContacts,
            ),
          ),
          Expanded(
            child: isMobile ? _buildMobileList() : _buildWebList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return CustomScrollView(
      slivers: [
        if (_filteredRegistered.isNotEmpty) ...[
          _buildHeader('On ConnectUs'),
          _buildSliverList(_filteredRegistered, true),
        ],
        if (_filteredNonRegistered.isNotEmpty) ...[
          _buildHeader('Invite to ConnectUs'),
          _buildSliverList(_filteredNonRegistered, false),
        ],
      ],
    );
  }

  Widget _buildWebList() {
    if (_isWebSearching) {
      return const Center(
          child: CircularProgressIndicator(color: AppTheme.accent));
    }
    if (_webSearchResults.isEmpty) {
      return const Center(
          child: Text("No users found", style: TextStyle(color: Colors.white)));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _webSearchResults.length,
      itemBuilder: (context, index) =>
          _buildContactTile(_webSearchResults[index], true),
    );
  }

  Widget _buildHeader(String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSliverList(List<Contact> list, bool reg) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (c, i) => _buildContactTile(list[i], reg),
            childCount: list.length),
      ),
    );
  }
}
