import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:encrypt/encrypt.dart' as encrypt;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  late IO.Socket _socket;
  final _encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));
  final _iv = encrypt.IV.fromLength(16);

  final Map<String, Function(Map<String, dynamic>)> _messageListeners = {};

  SocketService._internal() {
    _socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.onConnect((_) {
      print('Socket.IO connected');
    });

    _socket.on('message', (data) {
      if (data is Map<String, dynamic> && data['content'] != null) {
        data['content'] = _decrypt(data['content']);
        final from = data['from'];
        if (_messageListeners.containsKey(from)) {
          _messageListeners[from]!(data);
        }
      }
    });

    _socket.on('status', (data) => print('Socket.IO status: $data'));
    _socket.onDisconnect((_) => print('Socket.IO disconnected'));
    _socket.onError((data) => print('Socket.IO error: $data'));
  }

  void connect() {
    if (!_socket.connected) {
      _socket.connect();
    }
  }

  void addMessageListener(
      String userId, Function(Map<String, dynamic>) listener) {
    _messageListeners[userId] = listener;
  }

  void removeMessageListener(String userId) {
    _messageListeners.remove(userId);
  }

  void sendMessage(String to, String from, String content) {
    final encryptedContent = _encrypt(content);
    _socket.emit('privateMessage', {
      'to': to,
      'from': from,
      'content': encryptedContent,
    });
  }

  void register(String userId) {
    _socket.emit('register', userId);
  }

  String _encrypt(String text) {
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  String _decrypt(String text) {
    final encrypted = encrypt.Encrypted.fromBase64(text);
    final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
    return decrypted;
  }

  void dispose() {
    _socket.dispose();
  }
}
