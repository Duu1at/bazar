import 'dart:convert';

import 'package:auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interface/local_storage_exception.dart';
import 'interface/local_storage_interface.dart';

class MbStorage implements LocalStorageInterfaceSyncRead {
  const MbStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static Future<MbStorage> getInstance([SharedPreferences? pref]) async {
    return MbStorage._(pref ?? await SharedPreferences.getInstance());
  }

  @override
  Future<void> cacheUser({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (e) {
      throw LocalStorageException(e);
    }
  }

  @override
  Future<void> deleteUser({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (e) {
      throw LocalStorageException(e);
    }
  }

  @override
  Future<bool> isUserCached({required String key}) async {
    try {
      return await _sharedPreferences.getBool(key) ?? false;
    } catch (e) {
      throw LocalStorageException(e);
    }
  }

  @override
  Future<void> saveUser({required String key, required User value}) {
    try {
      return _sharedPreferences.setString(key, jsonEncode(value.toMap()));
    } catch (e) {
      throw LocalStorageException(e);
    }
  }

  @override
  Future<User> get getUser async {
    final data = _sharedPreferences.getString(AuthService.userKey);
    return data == null ? User.empty : User.fromMap(jsonDecode(data));
  }
}
