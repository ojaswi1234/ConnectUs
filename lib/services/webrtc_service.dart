import 'dart:async';
import 'dart:convert';

import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:ConnectUs/graphql/__generated__/schema.schema.gql.dart';
import 'package:ConnectUs/services/ferry_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Manages a single WebRTC peer connection for one call room.
/// Signaling (offer/answer/ICE) is done via the GraphQL callSignals subscription.
/// STUN is used for NAT traversal (add TURN for symmetric NATs in production).
class WebRTCService {
  final String roomId;
  final String localUserId;
  final bool isCaller;
  final WidgetRef ref;
  final bool videoEnabled;

  RTCPeerConnection? _pc;
  MediaStream? _localStream;
  StreamSubscription? _signalingSubscription;

  // Callbacks for the UI layer
  Function(MediaStream)? onLocalStream;
  Function(MediaStream)? onRemoteStream;
  Function()? onHangup;

  WebRTCService({
    required this.roomId,
    required this.localUserId,
    required this.isCaller,
    required this.ref,
    this.videoEnabled = true,
  });

  static const _iceConfig = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
      // TODO(ops): Add TURN credentials for production:
      // {'urls': 'turn:your.turn.server', 'username': 'x', 'credential': 'x'}
    ]
  };

  Future<void> init() async {
    _pc = await createPeerConnection(_iceConfig);

    _pc!.onIceCandidate = (RTCIceCandidate candidate) {
      if (candidate.candidate != null) {
        _sendSignal('ICE_CANDIDATE', jsonEncode({
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        }));
      }
    };

    _pc!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        onRemoteStream?.call(event.streams[0]);
      }
    };

    // Capture local media
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': videoEnabled ? {'facingMode': 'user'} : false,
    });
    onLocalStream?.call(_localStream!);
    for (final track in _localStream!.getTracks()) {
      _pc!.addTrack(track, _localStream!);
    }

    // Start listening for remote signals
    _listenToSignals();

    if (isCaller) {
      // Create and send the SDP offer
      final offer = await _pc!.createOffer();
      await _pc!.setLocalDescription(offer);
      _sendSignal('OFFER', jsonEncode({'sdp': offer.sdp, 'type': offer.type}));
    }
  }

  void _listenToSignals() {
    final gqlClient = ref.read(clientProvider);
    final req = GListenToCallSignalsReq((b) => b..vars.roomId = roomId);
    _signalingSubscription = gqlClient.request(req).listen((response) async {
      if (response.data == null) return;
      final sig = response.data!.callSignals;
      // Ignore our own echoed signals
      if (sig.senderId == localUserId) return;
      await _handleSignal(sig.type.name, sig.payload);
    });
  }

  Future<void> _handleSignal(String type, String payload) async {
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      switch (type) {
        case 'OFFER':
          await _pc!.setRemoteDescription(
            RTCSessionDescription(data['sdp'] as String, data['type'] as String),
          );
          final answer = await _pc!.createAnswer();
          await _pc!.setLocalDescription(answer);
          _sendSignal('ANSWER', jsonEncode({'sdp': answer.sdp, 'type': answer.type}));
          break;
        case 'ANSWER':
          await _pc!.setRemoteDescription(
            RTCSessionDescription(data['sdp'] as String, data['type'] as String),
          );
          break;
        case 'ICE_CANDIDATE':
          await _pc!.addCandidate(RTCIceCandidate(
            data['candidate'] as String,
            data['sdpMid'] as String?,
            data['sdpMLineIndex'] as int?,
          ));
          break;
        case 'HANGUP':
          onHangup?.call();
          break;
        default:
          debugPrint('[WebRTC] Unknown signal type: $type');
      }
    } catch (e) {
      debugPrint('[WebRTC] Signal handling error: $e');
    }
  }

  void _sendSignal(String type, String payload) {
    final gqlClient = ref.read(clientProvider);
    GCallSignalType enumType;
    switch (type) {
      case 'OFFER':
        enumType = GCallSignalType.OFFER;
        break;
      case 'ANSWER':
        enumType = GCallSignalType.ANSWER;
        break;
      case 'ICE_CANDIDATE':
        enumType = GCallSignalType.ICE_CANDIDATE;
        break;
      default:
        enumType = GCallSignalType.HANGUP;
    }
    final req = GSendCallSignalReq((b) => b
      ..vars.roomId = roomId
      ..vars.type = enumType
      ..vars.payload = payload);
    gqlClient.request(req).first.catchError((e) {
      debugPrint('[WebRTC] Failed to send signal: $e');
      return e;
    });
  }

  void toggleMute() {
    _localStream?.getAudioTracks().forEach((t) => t.enabled = !t.enabled);
  }

  void toggleVideo() {
    _localStream?.getVideoTracks().forEach((t) => t.enabled = !t.enabled);
  }

  void switchCamera() {
    final tracks = _localStream?.getVideoTracks();
    if (tracks != null && tracks.isNotEmpty) {
      Helper.switchCamera(tracks.first);
    }
  }

  Future<void> hangup() async {
    _sendSignal('HANGUP', '{}');
    await dispose();
  }

  Future<void> dispose() async {
    _signalingSubscription?.cancel();
    _localStream?.getTracks().forEach((t) => t.stop());
    await _localStream?.dispose();
    await _pc?.close();
    _pc = null;
  }
}
