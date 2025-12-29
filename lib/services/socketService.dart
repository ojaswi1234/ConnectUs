// socket_service.dart
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:logger/logger.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  io.Socket? _socket;
  final Logger _logger = Logger();
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  void initializeSocket() {
    if (_socket != null) return; // Prevent multiple initializations
    _socket = io.io(
      'https://wassup-backend-5isl.onrender.com',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(1000)
          .build(),
    );

    _socket?.onConnect((_) {
      _logger.i('Socket connected');
    });

    _socket?.onDisconnect((_) {
      _logger.e('Socket disconnected');
    });

    _socket?.onError((error) {
      _logger.e('Socket error: $error');
    });

    _socket?.on('message', (data) {
      _messageController.add(data);
    });
  }

  void joinRoom(String roomId) {
    _socket?.emit('join_room', roomId);
  }

  void sendMessage(String roomId, Map<String, dynamic> message) {
    _socket?.emit('message', {
      'room': roomId,
      'message': message,
    });
  }

  void getMessages(String roomId) {
    _socket?.emit('get_messages', {'room': roomId});
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
    _messageController.close();
  }

  io.Socket? get socket => _socket;
}
