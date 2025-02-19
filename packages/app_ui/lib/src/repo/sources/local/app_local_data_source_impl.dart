import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:persistent_storage/persistent_storage.dart';

@immutable
final class AppLocalDataSourceImpl implements AppLocalDataSource {
  const AppLocalDataSourceImpl({required this.storage});

  final PersistentStorage storage;

  static const _modeKey = 'mode';

  @override
  AppTheme initialTheme() {
    final isDark = storage.readBool(key: _modeKey);
    if (isDark != null && isDark) {
      return const AppDarkTheme();
    } else {
      return const AppLightTheme();
    }
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) async {
    await storage.writeBool(key: _modeKey, value: isDark);
  }
}
