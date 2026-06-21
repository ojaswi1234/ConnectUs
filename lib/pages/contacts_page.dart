import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

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

class _ContactsPageState extends State<ContactsPage> with AutomaticKeepAliveClientMixin {
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
                  .where((c) => c.displayName.toLowerCase().contains(lowerQuery))
                  .toList();
              _filteredNonRegistered = widget.nonRegisteredContacts
                  .where((c) => c.displayName.toLowerCase().contains(lowerQuery))
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
      final List<dynamic> response = await Supabase.instance.client
          .from('users')
          .select('usrname')
          .ilike('usrname', '%$query%')
          .limit(20);

      final results = response.map((userData) {
        final contact = Contact();
        contact.displayName = userData['usrname'] ?? 'Unknown User';
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
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          if (isRegistered || !isMobile) {
            Navigator.pop(context);
            widget.onContactTap(contact); // Triggers chat initiation
          } else {
            widget.onInviteContact(contact);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: AppTheme.coral.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isRegistered ? AppTheme.cyanRingGradient : null,
                  border: isRegistered ? null : Border.all(color: AppTheme.textMuted.withOpacity(0.3), width: 2),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: AppTheme.bgCool,
                  child: Text(
                    contact.displayName.isNotEmpty ? contact.displayName[0].toUpperCase() : '?',
                    style: TextStyle(color: isRegistered ? AppTheme.logoTeal : AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.displayName,
                      style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    if (contact.phones.isNotEmpty && isMobile) ...[
                      const SizedBox(height: 4),
                      Text(contact.phones.first.number, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
                    ]
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isRegistered ? AppTheme.logoCyan.withOpacity(0.1) : AppTheme.textMuted.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isRegistered ? 'Message' : 'Invite',
                  style: TextStyle(
                    color: isRegistered ? AppTheme.logoTeal : AppTheme.textMuted,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Select Contact', style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: isMobile ? 'Search contacts...' : 'Search via Username',
                hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
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
      return const Center(child: CircularProgressIndicator(color: AppTheme.coral));
    }
    if (_webSearchResults.isEmpty) {
      return const Center(child: Text("No users found", style: TextStyle(color: AppTheme.textMuted)));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _webSearchResults.length,
      itemBuilder: (context, index) => _buildContactTile(_webSearchResults[index], true),
    );
  }

  Widget _buildHeader(String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
        child: Text(text, style: const TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  Widget _buildSliverList(List<Contact> list, bool reg) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((c, i) => _buildContactTile(list[i], reg), childCount: list.length),
      ),
    );
  }
}
