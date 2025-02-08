import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = const FlutterSecureStorage();

  // Save values
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read values
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete values
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all storage
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
