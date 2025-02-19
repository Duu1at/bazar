import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/repo/repo.dart';
import 'package:app_ui/src/theme/app_light_theme.dart';
import 'package:flutter/material.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  AppTheme initialTheme() => const AppLightTheme();

  @override
  Future<void> saveThemeMode({required bool isDark}) => Future.value();
}
