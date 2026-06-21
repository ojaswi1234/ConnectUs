import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/utils/app_theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnectUs/providers/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
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
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final bool isOnline = _profile?['is_online'] == true;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.coral))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
                    ),
                    child: Column(
                      children: [
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
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.coral.withOpacity(0.4), width: 2)),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppTheme.peach,
                            child: Text(
                              _profile?['usrname']?.toString().substring(0, 1).toUpperCase() ?? 'U',
                              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.coral),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _profile?['usrname'] ?? 'User',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(color: AppTheme.bgCool, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 8, height: 8, decoration: BoxDecoration(color: isOnline ? AppTheme.online : AppTheme.offline, shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                              Text(isOnline ? 'Online' : 'Offline', style: const TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w600, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textMuted)),
                        const SizedBox(height: 16),
                        _InfoTile(icon: Icons.phone_outlined, label: 'Phone', value: _profile?['phone_number'] ?? 'Not set'),
                        const SizedBox(height: 12),
                        _InfoTile(icon: Icons.alternate_email, label: 'Username', value: _profile?['usrname'] ?? 'Not set'),
                        const SizedBox(height: 12),
                        _InfoTile(icon: Icons.email_outlined, label: 'Email', value: _profile?['email'] ?? 'Not set'),
                        const SizedBox(height: 32),
                        _ActionTile(icon: Icons.block, label: 'Blocked Users', color: Colors.redAccent, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Blocked Users list is currently empty.')));
                        }),
                        const SizedBox(height: 12),
                        _ActionTile(
                          icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          label: 'Dark Mode',
                          color: AppTheme.logoCyan,
                          hasSwitch: true,
                          switchValue: isDarkMode,
                          onTap: () {},
                          onSwitchChanged: (val) {
                            ref.read(themeModeProvider.notifier).state = val ? ThemeMode.dark : ThemeMode.light;
                          },
                        ),
                        const SizedBox(height: 12),
                        _ActionTile(icon: Icons.privacy_tip_outlined, label: 'Privacy', color: AppTheme.logoTeal, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Privacy settings clicked')));
                        }),
                        const SizedBox(height: 32),
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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppTheme.coral.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.bgCool, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.textMuted, size: 22)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool hasSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  });

  @override
  State<_ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<_ActionTile> {
  late bool _currentSwitchValue;

  @override
  void initState() {
    super.initState();
    _currentSwitchValue = widget.switchValue;
  }
  
  @override
  void didUpdateWidget(covariant _ActionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.switchValue != oldWidget.switchValue) {
      _currentSwitchValue = widget.switchValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: widget.hasSwitch ? () {
        setState(() {
          _currentSwitchValue = !_currentSwitchValue;
          widget.onSwitchChanged?.call(_currentSwitchValue);
        });
      } : widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: AppTheme.coral.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: widget.color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Icon(widget.icon, color: widget.color, size: 22)),
            const SizedBox(width: 16),
            Expanded(child: Text(widget.label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colorScheme.onSurface))),
            if (widget.hasSwitch)
              Switch(
                value: _currentSwitchValue,
                activeColor: AppTheme.coral,
                onChanged: (val) {
                  setState(() {
                    _currentSwitchValue = val;
                    widget.onSwitchChanged?.call(_currentSwitchValue);
                  });
                },
              )
            else
              Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textMuted.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
