import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _manager = StorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  factory StorageService() => _manager;

  Future<void> _ensurePrefsLoaded() async {
    if (_manager._prefs == null) {
      _manager._prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> isAuthenticated() async {
    return await _manager._storage.read(key: "token") != null;
  }

  Future<void> setAuthenticated(
    String? token,
    User? user,
  ) async {
    if (token == null) {
      if ((await _manager._storage.read(key: "token")) == null) {
        throw Exception(
            "You cannot pass until token when there's no token previously persisted.");
      }
    }
    if (token != null) {
      await _manager._storage.write(key: "token", value: token);
      await StorageService().saveHasAuthenticatedBefore(true);
    }
    // await saveUserDetails(user);
  }

  Future<void> saveHasAuthenticatedBefore(bool hasAuthenticated) async {
    await _manager._ensurePrefsLoaded();
    _manager._prefs!.setBool("Pref", hasAuthenticated);
  }

  StorageService._internal();
}
