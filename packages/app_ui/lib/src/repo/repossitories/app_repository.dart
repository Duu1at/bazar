import 'package:app_ui/app_ui.dart';

abstract class AppRepository {
  AppTheme getInitialThemeState();

  Future<void> saveThemeMode({required bool isDark});
}
