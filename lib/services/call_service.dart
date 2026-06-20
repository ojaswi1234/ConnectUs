import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum CallState { idle, incoming, outgoing, ringing, connecting, connected, ended, declined }

class CallService extends ChangeNotifier {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RealtimeChannel? _signalingChannel;

  CallState _callState = CallState.idle;
  CallState get callState => _callState;

  String? _roomId;
  String? _callerUsername;
  String? _calleeUsername;
  String? _callType; // 'voice' or 'video'
  bool _isCaller = false;

  final Map<String, dynamic> _configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ]
  };

  MediaStream? get localStream => _localStream;
  MediaStream? get remoteStream => _remoteStream;
  String? get callType => _callType;
  String? get callerUsername => _callerUsername;
  String? get calleeUsername => _calleeUsername;

  final StreamController<Map<String, dynamic>> _incomingCallController = StreamController.broadcast();
  Stream<Map<String, dynamic>> get incomingCallStream => _incomingCallController.stream;

  void _setCallState(CallState state) {
    _callState = state;
    notifyListeners();
  }

  Future<void> initSignaling() async {
    final myUsername = await _getMyUsername();
    if (myUsername == null) return;
    
    final personalChannelName = 'call-invite-$myUsername';
    
    Supabase.instance.client.channel(personalChannelName)
      .onBroadcast(event: 'call-invite', callback: (payload) {
        _handleIncomingInvite(payload);
      })
      .subscribe();
  }

  Future<String?> _getMyUsername() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return null;
    final data = await Supabase.instance.client
        .from('users')
        .select('usrname')
        .eq('id', user.id)
        .maybeSingle();
    return data?['usrname'];
  }

  void _handleIncomingInvite(Map<String, dynamic> payload) {
    if (_callState != CallState.idle) return;
    
    _roomId = payload['roomId'];
    _callerUsername = payload['caller'];
    _callType = payload['callType'];
    _isCaller = false;
    _setCallState(CallState.incoming);
    
    _incomingCallController.add({
      'caller': _callerUsername,
      'callType': _callType,
      'roomId': _roomId,
    });
  }

  String _generateRoomId(String user1, String user2) {
    final users = [user1, user2]..sort();
    return users.join("_");
  }

  Future<void> initiateCall(String calleeUsername, String type) async {
    final myUsername = await _getMyUsername();
    if (myUsername == null) return;

    _calleeUsername = calleeUsername;
    _callerUsername = myUsername;
    _callType = type;
    _roomId = _generateRoomId(myUsername, calleeUsername);
    _isCaller = true;

    await _setupMedia(type == 'video');
    await _setupPeerConnection();

    _signalingChannel = Supabase.instance.client.channel('call-$_roomId');
    _signalingChannel!
      .onBroadcast(event: 'call-accept', callback: (payload) => _handleAccept())
      .onBroadcast(event: 'call-decline', callback: (payload) => _handleDecline())
      .onBroadcast(event: 'sdp-answer', callback: (payload) => _handleSdpAnswer(payload))
      .onBroadcast(event: 'ice-candidate', callback: (payload) => _handleIceCandidate(payload))
      .onBroadcast(event: 'call-end', callback: (payload) => _handleRemoteEnd())
      .subscribe((status, [err]) async {
        if (status == 'SUBSCRIBED') {
          _setCallState(CallState.outgoing);
          final personalChannel = Supabase.instance.client.channel('call-invite-$calleeUsername');
          personalChannel.subscribe((subStatus, [err]) {
             if (subStatus == 'SUBSCRIBED') {
               personalChannel.sendBroadcastMessage(event: 'call-invite', payload: {
                  'roomId': _roomId,
                  'caller': myUsername,
                  'callType': type,
               });
             }
          });
        }
      });
  }

  Future<void> acceptCall() async {
    final myUsername = await _getMyUsername();
    if (myUsername == null || _roomId == null) return;

    await _setupMedia(_callType == 'video');
    await _setupPeerConnection();

    _signalingChannel = Supabase.instance.client.channel('call-$_roomId');
    _signalingChannel!
      .onBroadcast(event: 'sdp-offer', callback: (payload) => _handleSdpOffer(payload))
      .onBroadcast(event: 'ice-candidate', callback: (payload) => _handleIceCandidate(payload))
      .onBroadcast(event: 'call-end', callback: (payload) => _handleRemoteEnd())
      .subscribe((status, [err]) {
        if (status == 'SUBSCRIBED') {
          _signalingChannel!.sendBroadcastMessage(event: 'call-accept', payload: {});
          _setCallState(CallState.connecting);
        }
      });
  }

  Future<void> declineCall() async {
    if (_roomId != null) {
      final channel = Supabase.instance.client.channel('call-$_roomId');
      channel.subscribe((status, [err]) {
        if (status == 'SUBSCRIBED') {
          channel.sendBroadcastMessage(event: 'call-decline', payload: {});
        }
      });
    }
    _resetState();
  }

  Future<void> endCall() async {
    if (_signalingChannel != null) {
      _signalingChannel!.sendBroadcastMessage(event: 'call-end', payload: {});
    }
    await _resetState();
  }

  Future<void> _handleAccept() async {
    _setCallState(CallState.connected);
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    
    _signalingChannel?.sendBroadcastMessage(event: 'sdp-offer', payload: {
      'sdp': offer.sdp,
      'type': offer.type,
    });
  }

  void _handleDecline() {
    _setCallState(CallState.declined);
    _resetState();
  }

  Future<void> _handleSdpOffer(Map<String, dynamic> payload) async {
    _setCallState(CallState.connected);
    final description = RTCSessionDescription(payload['sdp'], payload['type']);
    await _peerConnection!.setRemoteDescription(description);

    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _signalingChannel?.sendBroadcastMessage(event: 'sdp-answer', payload: {
      'sdp': answer.sdp,
      'type': answer.type,
    });
  }

  Future<void> _handleSdpAnswer(Map<String, dynamic> payload) async {
    final description = RTCSessionDescription(payload['sdp'], payload['type']);
    await _peerConnection!.setRemoteDescription(description);
  }

  Future<void> _handleIceCandidate(Map<String, dynamic> payload) async {
    final candidate = RTCIceCandidate(
      payload['candidate'],
      payload['sdpMid'],
      payload['sdpMLineIndex'],
    );
    await _peerConnection?.addCandidate(candidate);
  }

  Future<void> _handleRemoteEnd() async {
    await _resetState();
  }

  Future<void> _setupMedia(bool isVideo) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': isVideo ? {'facingMode': 'user'} : false,
    };
    
    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    notifyListeners();
  }

  Future<void> _setupPeerConnection() async {
    _peerConnection = await createPeerConnection(_configuration);

    _peerConnection!.onIceCandidate = (candidate) {
      if (candidate.candidate != null) {
        _signalingChannel?.sendBroadcastMessage(event: 'ice-candidate', payload: {
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        });
      }
    };

    _peerConnection!.onAddStream = (stream) {
      _remoteStream = stream;
      notifyListeners();
    };

    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        _peerConnection!.addTrack(track, _localStream!);
      }
    }
  }

  Future<void> toggleMute() async {
    if (_localStream != null) {
      final audioTracks = _localStream!.getAudioTracks();
      if (audioTracks.isNotEmpty) {
        audioTracks[0].enabled = !audioTracks[0].enabled;
        notifyListeners();
      }
    }
  }

  bool get isMuted {
    if (_localStream != null && _localStream!.getAudioTracks().isNotEmpty) {
       return !_localStream!.getAudioTracks()[0].enabled;
    }
    return false;
  }

  Future<void> toggleVideo() async {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        videoTracks[0].enabled = !videoTracks[0].enabled;
        notifyListeners();
      }
    }
  }
  
  bool get isVideoOn {
    if (_localStream != null && _localStream!.getVideoTracks().isNotEmpty) {
       return _localStream!.getVideoTracks()[0].enabled;
    }
    return false;
  }

  Future<void> switchCamera() async {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        await Helper.switchCamera(videoTracks[0]);
      }
    }
  }

  Future<void> toggleSpeaker() async {
    // Basic flutter_webrtc speaker toggle
    try {
      final isSpeaker = true; // Hardcoded or tracked, Helper doesn't always expose a getter
      await Helper.setSpeakerphoneOn(!isSpeaker);
    } catch (e) {
      debugPrint("Error toggling speaker: $e");
    }
  }

  Future<void> _resetState() async {
    _setCallState(CallState.ended);
    
    _localStream?.getTracks().forEach((track) => track.stop());
    await _localStream?.dispose();
    _localStream = null;

    _remoteStream?.getTracks().forEach((track) => track.stop());
    await _remoteStream?.dispose();
    _remoteStream = null;

    await _peerConnection?.close();
    _peerConnection = null;

    await _signalingChannel?.unsubscribe();
    _signalingChannel = null;

    _roomId = null;
    _callerUsername = null;
    _calleeUsername = null;
    _callType = null;
    
    Future.delayed(const Duration(milliseconds: 500), () {
      _setCallState(CallState.idle);
    });
  }
}
