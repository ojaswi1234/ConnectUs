import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class WebRTCService {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  
  final String roomId;
  final bool isCaller;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  
  final SupabaseClient _supabase = Supabase.instance.client;
  RealtimeChannel? _signalingChannel;

  WebRTCService({
    required this.roomId,
    required this.isCaller,
    required this.localRenderer,
    required this.remoteRenderer,
  });

  Future<void> init() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:global.stun.twilio.com:3478'},
      ]
    };

    peerConnection = await createPeerConnection(configuration);

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      _sendSignal('ice-candidate', {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    peerConnection?.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        remoteStream = event.streams[0];
        remoteRenderer.srcObject = remoteStream;
      }
    };

    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
    });

    localRenderer.srcObject = localStream;
    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    _listenToSignaling();

    if (isCaller) {
      RTCSessionDescription offer = await peerConnection!.createOffer();
      await peerConnection!.setLocalDescription(offer);
      _sendSignal('offer', {'sdp': offer.sdp, 'type': offer.type});
    }
  }

  void _listenToSignaling() {
    _signalingChannel = _supabase.channel('public:call_signals:room_id=eq.$roomId');
    
    _signalingChannel?.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'call_signals',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'room_id',
        value: roomId,
      ),
      callback: (payload) {
        final data = payload.newRecord;
        final senderId = data['sender_id'];
        if (senderId == _supabase.auth.currentUser?.id) return; // ignore our own signals

        final signalType = data['signal_type'];
        final signalPayload = data['payload'] as Map<String, dynamic>;

        _handleSignal(signalType, signalPayload);
      },
    ).subscribe();
  }

  Future<void> _handleSignal(String type, Map<String, dynamic> payload) async {
    try {
      switch (type) {
        case 'offer':
          if (!isCaller) {
            await peerConnection?.setRemoteDescription(
              RTCSessionDescription(payload['sdp'], payload['type']),
            );
            RTCSessionDescription answer = await peerConnection!.createAnswer();
            await peerConnection!.setLocalDescription(answer);
            _sendSignal('answer', {'sdp': answer.sdp, 'type': answer.type});
          }
          break;
        case 'answer':
          if (isCaller) {
            await peerConnection?.setRemoteDescription(
              RTCSessionDescription(payload['sdp'], payload['type']),
            );
          }
          break;
        case 'ice-candidate':
          await peerConnection?.addCandidate(
            RTCIceCandidate(
              payload['candidate'],
              payload['sdpMid'],
              payload['sdpMLineIndex'],
            ),
          );
          break;
        case 'hangup':
          dispose();
          break;
      }
    } catch (e) {
      debugPrint('Error handling WebRTC signal: $e');
    }
  }

  Future<void> _sendSignal(String type, Map<String, dynamic> payload) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await _supabase.from('call_signals').insert({
      'room_id': roomId,
      'sender_id': userId,
      'signal_type': type,
      'payload': payload,
    });
  }

  void dispose() {
    _sendSignal('hangup', {});
    localStream?.getTracks().forEach((track) => track.stop());
    peerConnection?.close();
    _signalingChannel?.unsubscribe();
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;
  }
  
  void toggleMute() {
    if (localStream != null) {
      final audioTracks = localStream!.getAudioTracks();
      if (audioTracks.isNotEmpty) {
        audioTracks[0].enabled = !audioTracks[0].enabled;
      }
    }
  }

  void toggleVideo() {
    if (localStream != null) {
      final videoTracks = localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        videoTracks[0].enabled = !videoTracks[0].enabled;
      }
    }
  }

  void toggleCamera() {
    if (localStream != null) {
      final videoTracks = localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        Helper.switchCamera(videoTracks[0]);
      }
    }
  }
}
