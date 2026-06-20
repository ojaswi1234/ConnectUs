import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ConnectUs/services/webrtc_service.dart';

class Voice extends StatefulWidget {
  final String roomId;
  final bool isCaller;

  const Voice({super.key, required this.roomId, this.isCaller = false});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  WebRTCService? _webRTCService;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    
    _webRTCService = WebRTCService(
      roomId: widget.roomId,
      isCaller: widget.isCaller,
      localRenderer: _localRenderer,
      remoteRenderer: _remoteRenderer,
    );
    await _webRTCService!.init();
    
    // For voice calls, we turn off video by default
    _webRTCService!.toggleVideo();
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _webRTCService?.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 112, 0),
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                backgroundImage: AssetImage(
                    'assets/profile_placeholder.png'), // Replace with actual image
              ),
              const SizedBox(height: 20),
              const Text(
                'Caller Name', // Replace with dynamic caller name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Ringing...',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    speed: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(_isMuted ? Icons.mic_off : Icons.mic,
                        color: _isMuted ? Colors.red : Colors.white, size: 30),
                    onPressed: () {
                      _webRTCService?.toggleMute();
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.call_end, color: Colors.red, size: 50),
                    onPressed: () {
                      // Hang up logic
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      // Speaker logic
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
