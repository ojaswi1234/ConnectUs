import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SocketService {
  late WebSocketChannel _channel;
  final _encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));
  final _iv = encrypt.IV.fromLength(16);

  final Function(Map<String, dynamic>) onMessageReceived;

  SocketService({required this.onMessageReceived}) {
    // Replace with your server's public URL
    final uri = Uri.parse('ws://localhost:3000'); 
    _channel = WebSocketChannel.connect(uri);

    _channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      if (decodedMessage['content'] != null) {
        decodedMessage['content'] = _decrypt(decodedMessage['content']);
      }
      onMessageReceived(decodedMessage);
    });
  }

  void sendMessage(String to, String from, String content) {
    final encryptedContent = _encrypt(content);
    _channel.sink.add(jsonEncode({
      'type': 'privateMessage',
      'to': to,
      'from': from,
      'content': encryptedContent,
    }));
  }

  void register(String userId) {
    _channel.sink.add(jsonEncode({
      'type': 'register',
      'userId': userId,
    }));
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
    _channel.sink.close();
  }
}
