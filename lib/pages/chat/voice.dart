import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ConnectUs/services/call_service.dart';

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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 112, 0),
      appBar: AppBar(
        title: const Text('Voice Call'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Hide back button during call
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color.fromARGB(255, 124, 112, 0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/profile.png'), 
              ),
              const SizedBox(height: 20),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _statusText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(isMuted ? Icons.mic_off : Icons.mic,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      widget.callService.toggleMute();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.call_end, color: Colors.red, size: 70),
                    onPressed: () {
                      widget.callService.endCall();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      widget.callService.toggleSpeaker();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
