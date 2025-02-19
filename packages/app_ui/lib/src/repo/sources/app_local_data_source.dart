import 'package:app_ui/app_ui.dart';

abstract class AppLocalDataSource {
  AppTheme initialTheme();

  Future<void> saveThemeMode({required bool isDark});
}
