import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionKeyManager {
  static const _storage = FlutterSecureStorage();
  static const _keyName = 'connect_us_hive_aes_key';

  Future<Uint8List> getOrCreateEncryptionKey() async {
    final existingKeyStr = await _storage.read(key: _keyName);
    
    if (existingKeyStr != null) {
      return base64Url.decode(existingKeyStr);
    } else {
      // Generate a new 32-byte key
      final random = Random.secure();
      final keyBytes = Uint8List(32);
      for (var i = 0; i < 32; i++) {
        keyBytes[i] = random.nextInt(256);
      }
      
      final keyStr = base64Url.encode(keyBytes);
      await _storage.write(key: _keyName, value: keyStr);
      
      return keyBytes;
    }
  }

  Future<void> rotateKey() async {
    // Generate a new 32-byte key
    final random = Random.secure();
    final keyBytes = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      keyBytes[i] = random.nextInt(256);
    }
    
    final keyStr = base64Url.encode(keyBytes);
    await _storage.write(key: _keyName, value: keyStr);
  }
}
