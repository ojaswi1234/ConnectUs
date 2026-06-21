import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ConnectUs/services/call_service.dart';
import 'package:ConnectUs/utils/app_theme.dart';

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
      backgroundColor: AppTheme.headerDark,
      body: Stack(
        children: [
          // Main video area (remote user)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppTheme.headerDark,
            child: widget.callService.remoteStream != null
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.cyanRingGradient),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppTheme.bgCool,
                            child: Text(
                              widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : '?',
                              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Connecting...',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
          ),
          
          // Self video preview (top right)
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.logoCyan.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: widget.callService.localStream != null && isVideoOn
                    ? RTCVideoView(
                        _localRenderer,
                        mirror: true,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      )
                    : Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(Icons.videocam_off, color: Colors.white70, size: 40),
                        ),
                      ),
              ),
            ),
          ),

          // Header Info
          Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: isMuted ? Icons.mic_off : Icons.mic,
                  color: isMuted ? Colors.white : AppTheme.textDark,
                  backgroundColor: isMuted ? Colors.redAccent : Colors.white,
                  onPressed: () => widget.callService.toggleMute(),
                ),
                _buildControlButton(
                  icon: Icons.call_end,
                  color: Colors.white,
                  backgroundColor: Colors.red,
                  size: 72,
                  iconSize: 36,
                  onPressed: () => widget.callService.endCall(),
                ),
                _buildControlButton(
                  icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
                  color: isVideoOn ? AppTheme.textDark : Colors.white,
                  backgroundColor: isVideoOn ? Colors.white : Colors.redAccent,
                  onPressed: () => widget.callService.toggleVideo(),
                ),
                _buildControlButton(
                  icon: Icons.flip_camera_ios,
                  color: AppTheme.textDark,
                  backgroundColor: Colors.white,
                  onPressed: () => widget.callService.switchCamera(),
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
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Center(
          child: Icon(icon, color: color, size: iconSize),
        ),
      ),
    );
  }
}