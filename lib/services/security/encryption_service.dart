import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  late final Key _key;
  late final IV _iv;
  late final Encrypter _encrypter;

  // Initialize with a secure key (in production, store this securely)
  void initialize({String? key}) {
    final keyString = key ?? _generateKey();
    _key = Key.fromBase64(keyString);
    _iv = IV.fromSecureRandom(16);
    _encrypter = Encrypter(AES(_key));
  }

  // Generate a secure key
  String _generateKey() {
    final key = Key.fromSecureRandom(32);
    return key.base64;
  }

  // Encrypt string data
  String encryptString(String plainText) {
    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  // Decrypt string data
  String decryptString(String encryptedText) {
    try {
      final encrypted = Encrypted.fromBase64(encryptedText);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  // Encrypt JSON data
  String encryptJson(Map<String, dynamic> data) {
    try {
      final jsonString = jsonEncode(data);
      return encryptString(jsonString);
    } catch (e) {
      throw Exception('JSON encryption failed: $e');
    }
  }

  // Decrypt JSON data
  Map<String, dynamic> decryptJson(String encryptedData) {
    try {
      final jsonString = decryptString(encryptedData);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('JSON decryption failed: $e');
    }
  }

  // Hash sensitive data (one-way)
  String hashData(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Hash with salt for passwords
  String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate salt
  String generateSalt() {
    final salt = Key.fromSecureRandom(16);
    return salt.base64;
  }

  // Encrypt file data
  Uint8List encryptFile(Uint8List fileData) {
    try {
      final encrypted = _encrypter.encryptBytes(fileData, iv: _iv);
      return encrypted.bytes;
    } catch (e) {
      throw Exception('File encryption failed: $e');
    }
  }

  // Decrypt file data
  Uint8List decryptFile(Uint8List encryptedData) {
    try {
      final encrypted = Encrypted(encryptedData);
      return _encrypter.decryptBytes(encrypted, iv: _iv);
    } catch (e) {
      throw Exception('File decryption failed: $e');
    }
  }

  // Encrypt sensitive fields in a model
  Map<String, dynamic> encryptSensitiveFields(
    Map<String, dynamic> data,
    List<String> sensitiveFields,
  ) {
    final encryptedData = Map<String, dynamic>.from(data);
    
    for (final field in sensitiveFields) {
      if (encryptedData.containsKey(field) && encryptedData[field] != null) {
        final value = encryptedData[field].toString();
        encryptedData[field] = encryptString(value);
        encryptedData['${field}_encrypted'] = true;
      }
    }
    
    return encryptedData;
  }

  // Decrypt sensitive fields in a model
  Map<String, dynamic> decryptSensitiveFields(
    Map<String, dynamic> data,
    List<String> sensitiveFields,
  ) {
    final decryptedData = Map<String, dynamic>.from(data);
    
    for (final field in sensitiveFields) {
      if (decryptedData['${field}_encrypted'] == true && 
          decryptedData.containsKey(field) && 
          decryptedData[field] != null) {
        final encryptedValue = decryptedData[field].toString();
        decryptedData[field] = decryptString(encryptedValue);
        decryptedData.remove('${field}_encrypted');
      }
    }
    
    return decryptedData;
  }

  // Encrypt API key
  String encryptApiKey(String apiKey) {
    // Use a different encryption method for API keys
    final hmac = Hmac(sha256, utf8.encode(_key.base64));
    final digest = hmac.convert(utf8.encode(apiKey));
    return digest.toString();
  }

  // Verify encrypted API key
  bool verifyApiKey(String apiKey, String encryptedApiKey) {
    final encrypted = encryptApiKey(apiKey);
    return encrypted == encryptedApiKey;
  }
}