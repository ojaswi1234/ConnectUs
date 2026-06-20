import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ConnectUs/services/call_service.dart';

class Video extends StatefulWidget {
  final String userName;
  final CallService callService;

  const Video({super.key, required this.userName, required this.callService});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initRenderers();
    widget.callService.addListener(_onCallStateChanged);
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    _updateRenderers();
  }

  void _onCallStateChanged() {
    if (!mounted) return;
    
    final state = widget.callService.callState;
    if (state == CallState.ended || state == CallState.declined) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } else {
      _updateRenderers();
      setState(() {});
    }
  }

  void _updateRenderers() {
    if (widget.callService.localStream != null) {
      _localRenderer.srcObject = widget.callService.localStream;
    }
    if (widget.callService.remoteStream != null) {
      _remoteRenderer.srcObject = widget.callService.remoteStream;
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    widget.callService.removeListener(_onCallStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = widget.callService.isMuted;
    final isVideoOn = widget.callService.isVideoOn;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Video Call',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
            onPressed: () {
              widget.callService.switchCamera();
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main video area (remote user)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: widget.callService.remoteStream != null
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFFFFC107),
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Connecting...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          
          // Self video preview (top right)
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: widget.callService.localStream != null && isVideoOn
                    ? RTCVideoView(
                        _localRenderer,
                        mirror: true,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      )
                    : Container(
                        color: Colors.grey[700],
                        child: const Center(
                          child: Icon(
                            Icons.videocam_off,
                            color: Colors.white70,
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          
          // Bottom controls
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: isMuted ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    backgroundColor: Colors.grey[700]!,
                    onPressed: () {
                      widget.callService.toggleMute();
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    color: Colors.white,
                    backgroundColor: Colors.red,
                    size: 70,
                    iconSize: 35,
                    onPressed: () {
                      widget.callService.endCall();
                    },
                  ),
                  _buildControlButton(
                    icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
                    color: Colors.white,
                    backgroundColor: Colors.grey[700]!,
                    onPressed: () {
                      widget.callService.toggleVideo();
                    },
                  ),
                ],
              ),
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
    double size = 60,
    double iconSize = 28,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}