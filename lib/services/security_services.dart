// lib/services/security_service.dart
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SecurityService {
  // In a real app, derive this from a user password or secure key exchange.
  // For now, we use a static 32-byte key for consistency across restarts.
  static final _key = encrypt.Key.fromUtf8('ConnectUsSecureKey32BytesLong!!!');
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter =
      encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));

  /// Compresses and Encrypts a message
  static String encryptMessage(String plainText) {
    try {
      // 1. Compress (GZip)
      List<int> stringBytes = utf8.encode(plainText);
      List<int>? compressed = GZipEncoder().encode(stringBytes);

      // 2. Encrypt
      final encrypted = _encrypter.encryptBytes(compressed, iv: _iv);

      // Return Base64 string to send to server
      return encrypted.base64;
    } catch (e) {
      print("Encryption Error: $e");
      return plainText; // Fallback to plain if failed (or handle error)
    }
  }

  /// Decrypts and Decompresses a message
  static String decryptMessage(String encryptedBase64) {
    try {
      // 1. Decrypt
      final encrypted = encrypt.Encrypted.fromBase64(encryptedBase64);
      final decryptedBytes = _encrypter.decryptBytes(encrypted, iv: _iv);

      // 2. Decompress (GZip)
      final decompressed = GZipDecoder().decodeBytes(decryptedBytes);

      return utf8.decode(decompressed);
    } catch (e) {
      // If it fails (e.g., message wasn't encrypted), return original
      return encryptedBase64;
    }
  }
}
