import 'package:ConnectUs/services/webrtc_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallPage extends ConsumerStatefulWidget {
  final String roomId;
  final String localUserId;
  final bool isCaller;

  const VideoCallPage({
    super.key,
    required this.roomId,
    required this.localUserId,
    this.isCaller = false,
  });

  @override
  ConsumerState<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends ConsumerState<VideoCallPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  WebRTCService? _service;
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initCall();
  }

  Future<void> _initCall() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    _service = WebRTCService(
      roomId: widget.roomId,
      localUserId: widget.localUserId,
      isCaller: widget.isCaller,
      ref: ref,
      videoEnabled: true,
    );

    _service!.onLocalStream = (stream) {
      if (mounted) setState(() => _localRenderer.srcObject = stream);
    };
    _service!.onRemoteStream = (stream) {
      if (mounted) {
        setState(() {
          _remoteRenderer.srcObject = stream;
          _isConnected = true;
        });
      }
    };
    _service!.onHangup = () {
      if (mounted) Navigator.pop(context);
    };

    await _service!.init();
  }

  @override
  void dispose() {
    _service?.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video (fullscreen)
          if (_isConnected)
            RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            )
          else
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Connecting...',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

          // Local video preview (top-right corner)
          Positioned(
            top: 60,
            right: 20,
            width: 120,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
          ),

          // Back button
          Positioned(
            top: 48,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  _service?.hangup().then((_) => Navigator.pop(context)),
            ),
          ),

          // Flip camera
          Positioned(
            top: 48,
            right: 160,
            child: IconButton(
              icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
              onPressed: () => _service?.switchCamera(),
            ),
          ),

          // Control buttons bar
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _controlBtn(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  bg: _isMuted ? Colors.red : Colors.grey[700]!,
                  onTap: () {
                    _service?.toggleMute();
                    setState(() => _isMuted = !_isMuted);
                  },
                ),
                _controlBtn(
                  icon: Icons.call_end,
                  bg: Colors.red,
                  size: 70,
                  onTap: () =>
                      _service?.hangup().then((_) => Navigator.pop(context)),
                ),
                _controlBtn(
                  icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                  bg: _isVideoOff ? Colors.red : Colors.grey[700]!,
                  onTap: () {
                    _service?.toggleVideo();
                    setState(() => _isVideoOff = !_isVideoOff);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlBtn({
    required IconData icon,
    required Color bg,
    required VoidCallback onTap,
    double size = 60,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}