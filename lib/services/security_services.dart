import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:logger/logger.dart';

class SecurityService {
  static encrypt.Key? _key;
  static encrypt.Encrypter? _encrypter;

  static void initialize(Uint8List keyBytes) {
    _key = encrypt.Key(keyBytes);
    _encrypter = encrypt.Encrypter(encrypt.AES(_key!, mode: encrypt.AESMode.cbc));
  }

  /// Compresses and Encrypts a message
  static String encryptMessage(String plainText) {
    if (_encrypter == null) {
      Logger(printer: PrettyPrinter()).w("SecurityService not initialized. Returning plaintext.");
      return plainText;
    }
    
    try {
      // Generate a random 16-byte IV for every encryption
      final random = Random.secure();
      final ivBytes = Uint8List(16);
      for (var i = 0; i < 16; i++) {
        ivBytes[i] = random.nextInt(256);
      }
      final iv = encrypt.IV(ivBytes);

      // 1. Compress (GZip)
      List<int> stringBytes = utf8.encode(plainText);
      List<int> compressed = const GZipEncoder().encode(stringBytes) ?? [];

      // 2. Encrypt
      final encrypted = _encrypter!.encryptBytes(compressed, iv: iv);

      // Prepend the IV to the ciphertext
      final ivPlusCiphertext = Uint8List.fromList([...ivBytes, ...encrypted.bytes]);

      // Return Base64 string to send to server
      return base64.encode(ivPlusCiphertext);
    } catch (e) {
      Logger(printer: PrettyPrinter()).e("Encryption Error: $e");
      return plainText; // Fallback to plain if failed (or handle error)
    }
  }

  /// Decrypts and Decompresses a message
  static String decryptMessage(String encryptedBase64) {
    if (_encrypter == null) {
      return encryptedBase64;
    }
    
    try {
      final combinedBytes = base64.decode(encryptedBase64);
      
      // If it's too short to contain an IV, it might be unencrypted or old format
      if (combinedBytes.length <= 16) {
        return encryptedBase64;
      }
      
      // Extract the IV (first 16 bytes)
      final ivBytes = combinedBytes.sublist(0, 16);
      final iv = encrypt.IV(ivBytes);
      
      // Extract the ciphertext
      final ciphertextBytes = combinedBytes.sublist(16);
      final encrypted = encrypt.Encrypted(ciphertextBytes);

      // 1. Decrypt
      final decryptedBytes = _encrypter!.decryptBytes(encrypted, iv: iv);

      // 2. Decompress (GZip)
      final decompressed = const GZipDecoder().decodeBytes(decryptedBytes);

      return utf8.decode(decompressed);
    } catch (e) {
      // If it fails (e.g., message wasn't encrypted or old format), return original
      return encryptedBase64;
    }
  }
}
