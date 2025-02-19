import 'package:app_ui/src/repo/repo.dart';

abstract class LocalThemeDataSource {
  ReadThemeData getInitialThemeState();

  Future<void> saveThemeState(ReadThemeData themeState);
}
