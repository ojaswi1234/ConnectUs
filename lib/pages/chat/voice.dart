import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ConnectUs/services/call_service.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class Voice extends StatefulWidget {
  final String userName;
  final CallService callService;

  const Voice({super.key, required this.userName, required this.callService});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    widget.callService.addListener(_onCallStateChanged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.callService.removeListener(_onCallStateChanged);
    super.dispose();
  }

  void _onCallStateChanged() {
    if (!mounted) return;
    
    final state = widget.callService.callState;
    if (state == CallState.connected && _timer == null) {
      _startTimer();
    } else if (state == CallState.ended || state == CallState.declined) {
      _timer?.cancel();
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  String get _formattedTime {
    final minutes = (_seconds / 60).floor();
    final seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get _statusText {
    switch (widget.callService.callState) {
      case CallState.idle:
      case CallState.ended:
        return 'Call Ended';
      case CallState.declined:
        return 'Call Declined';
      case CallState.outgoing:
        return 'Calling...';
      case CallState.ringing:
        return 'Ringing...';
      case CallState.connecting:
        return 'Connecting...';
      case CallState.connected:
        return _formattedTime;
      case CallState.incoming:
        return 'Incoming Call...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = widget.callService.isMuted;
    final isSpeaker = widget.callService.isSpeakerOn ?? false; // Make sure to expose this if possible, default to false

    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      body: Stack(
        children: [
          // Background Gradient Bubble
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.cyanRingGradient.scale(0.5),
                boxShadow: [BoxShadow(color: AppTheme.logoCyan.withOpacity(0.3), blurRadius: 100)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top Nav
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                          child: const Icon(Icons.keyboard_arrow_down, color: AppTheme.textDark),
                        ),
                      ),
                      const Text('Voice Call', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      const SizedBox(width: 48), // Balance
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Avatar
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.coralGradient, boxShadow: [BoxShadow(color: AppTheme.coral.withOpacity(0.3), blurRadius: 30, spreadRadius: 10)]),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.bgWarm),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppTheme.surface,
                      child: Text(
                        widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Info
                Text(widget.userName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                Text(_statusText, style: TextStyle(fontSize: 16, color: AppTheme.textMuted.withOpacity(0.8))),
                
                const Spacer(flex: 2),
                
                // Controls Container
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.headerDark,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildControlButton(
                          icon: isMuted ? Icons.mic_off : Icons.mic,
                          color: isMuted ? AppTheme.textDark : Colors.white,
                          backgroundColor: isMuted ? Colors.white : Colors.white.withOpacity(0.2),
                          onPressed: () => widget.callService.toggleMute(),
                        ),
                        _buildControlButton(
                          icon: Icons.call_end,
                          color: Colors.white,
                          backgroundColor: Colors.redAccent,
                          size: 72,
                          iconSize: 36,
                          onPressed: () => widget.callService.endCall(),
                        ),
                        _buildControlButton(
                          icon: isSpeaker ? Icons.volume_up : Icons.volume_down,
                          color: isSpeaker ? AppTheme.textDark : Colors.white,
                          backgroundColor: isSpeaker ? Colors.white : Colors.white.withOpacity(0.2),
                          onPressed: () => widget.callService.toggleSpeaker(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onPressed,
    double size = 56,
    double iconSize = 26,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, color: color, size: iconSize),
        ),
      ),
    );
  }
}
