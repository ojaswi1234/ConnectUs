// lib/services/security_services.dart
//
// Real E2E encryption using X25519 key exchange + AES-256-GCM.
// Each conversation derives a shared secret via Diffie-Hellman.
// Each message uses a fresh random nonce (IV).
import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  static const _storage = FlutterSecureStorage();
  static const _privateKeyStorageKey = 'e2e_private_key_x25519';
  static const _publicKeyStorageKey = 'e2e_public_key_x25519';

  static final _x25519 = X25519();
  static final _aesGcm = AesGcm.with256bits();

  // -------------------------------------------------------------------------
  // Key Management
  // -------------------------------------------------------------------------

  /// Generates a fresh X25519 key pair and persists it in secure storage.
  /// Call once during registration / first launch.
  static Future<SimpleKeyPair> generateAndStoreKeyPair() async {
    final keyPair = await _x25519.newKeyPair();
    final privateBytes = await keyPair.extractPrivateKeyBytes();
    final publicKey = await keyPair.extractPublicKey();
    await _storage.write(
        key: _privateKeyStorageKey, value: base64.encode(privateBytes));
    await _storage.write(
        key: _publicKeyStorageKey,
        value: base64.encode(publicKey.bytes));
    return keyPair;
  }

  /// Loads the local X25519 key pair from secure storage.
  /// Returns null if no key pair has been generated yet.
  static Future<SimpleKeyPair?> loadKeyPair() async {
    final privateB64 = await _storage.read(key: _privateKeyStorageKey);
    final publicB64 = await _storage.read(key: _publicKeyStorageKey);
    if (privateB64 == null || publicB64 == null) return null;
    final privateBytes = base64.decode(privateB64);
    return await _x25519.newKeyPairFromSeed(privateBytes);
  }

  /// Returns the local public key bytes as a base64 string suitable for
  /// storing in the `users.public_key` Supabase column.
  static Future<String?> getLocalPublicKeyBase64() async {
    return _storage.read(key: _publicKeyStorageKey);
  }

  // -------------------------------------------------------------------------
  // Shared-Secret Derivation
  // -------------------------------------------------------------------------

  /// Derives a 256-bit shared secret from our private key and the remote peer's public key.
  static Future<SecretKey> deriveSharedSecret(
    SimpleKeyPair myKeyPair,
    String peerPublicKeyBase64,
  ) async {
    final peerPublicKeyBytes = base64.decode(peerPublicKeyBase64);
    final peerPublicKey = SimplePublicKey(peerPublicKeyBytes,
        type: KeyPairType.x25519);
    return await _x25519.sharedSecretKey(
      keyPair: myKeyPair,
      remotePublicKey: peerPublicKey,
    );
  }

  // -------------------------------------------------------------------------
  // Encrypt / Decrypt
  // -------------------------------------------------------------------------

  /// Encrypts [plainText] using a shared AES-256-GCM key derived from
  /// [peerPublicKeyBase64]. Returns a base64 string containing the
  /// nonce + MAC + ciphertext, all concatenated.
  ///
  /// Different messages - even identical plaintext - will produce different
  /// ciphertext because a fresh random nonce is generated for every call.
  static Future<String> encryptMessage(
    String plainText,
    String peerPublicKeyBase64, {
    SimpleKeyPair? myKeyPair,
  }) async {
    final kp = myKeyPair ?? await loadKeyPair();
    if (kp == null) throw StateError('No local key pair found');

    final sharedKey = await deriveSharedSecret(kp, peerPublicKeyBase64);

    final secretBox = await _aesGcm.encryptString(
      plainText,
      secretKey: sharedKey,
    );

    // Wire format: nonce(12) + mac(16) + ciphertext
    final combined = Uint8List.fromList([
      ...secretBox.nonce,
      ...secretBox.mac.bytes,
      ...secretBox.cipherText,
    ]);
    return base64.encode(combined);
  }

  /// Decrypts a [cipherBase64] string produced by [encryptMessage].
  /// Falls back to returning the raw input if decryption fails
  /// (e.g., legacy plaintext messages before E2E was enabled).
  static Future<String> decryptMessage(
    String cipherBase64,
    String peerPublicKeyBase64, {
    SimpleKeyPair? myKeyPair,
  }) async {
    try {
      final kp = myKeyPair ?? await loadKeyPair();
      if (kp == null) return cipherBase64; // No key - show as-is

      final sharedKey = await deriveSharedSecret(kp, peerPublicKeyBase64);

      final combined = base64.decode(cipherBase64);
      const nonceLen = 12;
      const macLen = 16;
      if (combined.length < nonceLen + macLen) return cipherBase64;

      final nonce = combined.sublist(0, nonceLen);
      final mac = Mac(combined.sublist(nonceLen, nonceLen + macLen));
      final cipherText = combined.sublist(nonceLen + macLen);

      final secretBox = SecretBox(cipherText, nonce: nonce, mac: mac);
      return await _aesGcm.decryptString(secretBox, secretKey: sharedKey);
    } catch (_) {
      // Return ciphertext as-is if decryption fails (e.g. legacy msg)
      return cipherBase64;
    }
  }

  // -------------------------------------------------------------------------
  // Legacy fallback (kept for API compatibility with existing callers)
  // These two synchronous stubs will be removed once chat_area.dart is updated.
  // -------------------------------------------------------------------------

  /// @deprecated Use encryptMessage() instead. Kept for temporary compatibility.
  static String encryptMessageSync(String plainText) => plainText;

  /// @deprecated Use decryptMessage() instead. Kept for temporary compatibility.
  static String decryptMessageSync(String cipherBase64) => cipherBase64;
}
