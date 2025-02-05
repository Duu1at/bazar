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
  Future<void> deleteUser({required String key}) {
    try {
      return _sharedPreferences.remove(key);
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
  Future<User> getUser({required String key}) async {
    try {
      final jsonString = _sharedPreferences.getString(key);
      if (jsonString == null || jsonString.isEmpty) {
        return User.empty;
      }
      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      return User.fromMap(userMap);
    } catch (e) {
      return User.empty;
    }
  }

  @override
  bool? readBool({required String key}) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeString({required String key, required String value}) {
    try {
      return _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeBool({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }
}
