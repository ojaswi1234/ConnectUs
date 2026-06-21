import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic>? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    try {
      final data = await _supabase.from('users').select('usrname, phone_number, email, is_online').eq('id', user.id).maybeSingle();
      setState(() {
        _profile = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    await _supabase.auth.signOut();
    if (mounted) Navigator.pushReplacementNamed(context, '/landing');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppTheme.coral))
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                                  child: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppTheme.textDark),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Profile Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: AppTheme.coralGradient,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [BoxShadow(color: AppTheme.coral.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    child: Text(
                                      _profile?['usrname']?.toString().substring(0, 1).toUpperCase() ?? 'U',
                                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _profile?['usrname'] ?? 'User',
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _profile?['email'] ?? 'No email',
                                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                                      const SizedBox(width: 6),
                                      Text(
                                        _profile?['is_online'] == true ? 'Online' : 'Offline',
                                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Info Tiles
                          _InfoTile(icon: Icons.phone_outlined, label: 'Phone', value: _profile?['phone_number'] ?? 'Not set'),
                          const SizedBox(height: 12),
                          _InfoTile(icon: Icons.alternate_email, label: 'Username', value: _profile?['usrname'] ?? 'Not set'),
                          const SizedBox(height: 12),
                          _InfoTile(icon: Icons.email_outlined, label: 'Email', value: _profile?['email'] ?? 'Not set'),
                          const SizedBox(height: 32),
                          // Actions
                          _ActionTile(icon: Icons.block, label: 'Blocked Users', color: Colors.redAccent, onTap: () {}),
                          const SizedBox(height: 12),
                          _ActionTile(icon: Icons.notifications_outlined, label: 'Notifications', color: AppTheme.logoCyan, onTap: () {}),
                          const SizedBox(height: 12),
                          _ActionTile(icon: Icons.privacy_tip_outlined, label: 'Privacy', color: AppTheme.logoTeal, onTap: () {}),
                          const SizedBox(height: 32),
                          // Logout
                          GestureDetector(
                            onTap: _logout,
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.red.withOpacity(0.2))),
                              child: const Center(child: Text('Log Out', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600))),
                            ),
                          ),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardShadow,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppTheme.peach, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: AppTheme.coral, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 13, color: AppTheme.textMuted.withOpacity(0.7))),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.cardShadow,
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: color, size: 22)),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark))),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textMuted.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
