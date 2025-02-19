import 'dart:convert';
import 'package:app_ui/src/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:persistent_storage/persistent_storage.dart';

@immutable
final class LocalThemeDataSourceImpl implements LocalThemeDataSource {
  const LocalThemeDataSourceImpl(this.storage);

  final PersistentStorage storage;

  static const _readThemeKey = 'readThemeKey';

  @override
  ReadThemeData getInitialThemeState() {
    final value = storage.readString(key: _readThemeKey);
    if (value == null) return ReadThemeData.initial;
    return ReadThemeData.fromJson(json.decode(value) as Map<String, dynamic>);
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: _readThemeKey, value: value);
  }
}
