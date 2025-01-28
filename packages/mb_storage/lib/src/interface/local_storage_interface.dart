abstract class LocalStorageInterfaceSyncRead {
  String? readString({required String key});
  bool? readBool({required String key});
  double? readDouble({required String key});
  int? readInt({required String key});
  List<String>? readStringList({required String key});
  Future<bool> writeString({required String key, required String value});
  Future<bool> writeBool({required String key, required bool value});
  Future<bool> writeDouble({required String key, required double value});
  Future<bool> writeInt({required String key, required int value});
  Future<bool> writeStringList({required String key, required List<String> value});
  Future<bool> delete({required String key});
  Future<bool> clear();
}
