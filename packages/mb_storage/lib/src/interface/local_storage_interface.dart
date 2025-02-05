import 'package:auth_service/auth_service.dart';

abstract class LocalStorageInterfaceSyncRead {
  Future<void> cacheUser({required String key, required bool value});
  Future<bool> isUserCached({required String key});
  Future<void> deleteUser({required String key});
  Future<void> saveUser({required String key, required User value});
  Future<User> getUser({required String key});
  bool? readBool({required String key});
  Future<bool> writeString({required String key, required String value});
  Future<bool> writeBool({required String key, required bool value});
}
