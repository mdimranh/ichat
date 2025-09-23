import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // Singleton pattern
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() => _instance;
  SecureStorageHelper._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Keys for storage
  static const String _keyAuthToken = 'auth_token';
  static const String _keyDeviceId = 'device_id';
  static const String _keyIsLoggedIn = 'is_logged_in';

  /// Save auth token securely
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
    await _storage.write(key: _keyIsLoggedIn, value: 'true');
  }

  /// Read auth token
  Future<String?> getAuthToken() async {
    return await _storage.read(key: _keyAuthToken);
  }

  /// Save user ID (or other user info as string)
  Future<void> saveDeviceId(String deviceId) async {
    await _storage.write(key: _keyDeviceId, value: deviceId);
  }

  /// Read user ID
  Future<String?> getDeviceId() async {
    return await _storage.read(key: _keyDeviceId);
  }

  /// Mark user logged out: clear all data
  Future<void> clearSession() async {
    await _storage.delete(key: _keyAuthToken);
    await _storage.delete(key: _keyDeviceId);
  }

  /// Check if user session exists on app launch
  Future<bool> isUserLoggedIn() async {
    String? loggedIn = await _storage.read(key: _keyIsLoggedIn);
    if (loggedIn == 'true') {
      // Optionally validate token here (expiry check)
      return true;
    }
    return false;
  }
}
