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
  String? readString({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
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
  double? readDouble({required String key}) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  int? readInt({required String key}) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  List<String>? readStringList({required String key}) {
    try {
      return _sharedPreferences.getStringList(key);
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

  @override
  Future<bool> writeDouble({required String key, required double value}) {
    try {
      return _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeInt({required String key, required int value}) {
    try {
      return _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeStringList({required String key, required List<String> value}) {
    try {
      return _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> clear() {
    try {
      return _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw LocalStorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> delete({required String key}) {
    try {
      return _sharedPreferences.remove(key);
    } catch (e, s) {
      throw LocalStorageException(e, s);
    }
  }
}
