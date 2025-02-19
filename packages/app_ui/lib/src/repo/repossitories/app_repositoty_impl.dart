import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/repo/repo.dart';
import 'package:flutter/material.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.dataSource);

  final AppLocalDataSource dataSource;

  @override
  AppTheme getInitialThemeState() {
    return dataSource.initialTheme();
  }

  @override
  Future<void> saveThemeMode({required bool isDark}) {
    return dataSource.saveThemeMode(isDark: isDark);
  }
}
