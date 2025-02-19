import 'package:app_ui/src/repo/repo.dart';
import 'package:flutter/material.dart';

@immutable
final class ReadThemeRepositoryImpl implements ReadThemeRepository {
  const ReadThemeRepositoryImpl(this.localThemeDataSource);

  final LocalThemeDataSource localThemeDataSource;

  @override
  ReadThemeData getInitialThemeState() {
    return localThemeDataSource.getInitialThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return localThemeDataSource.saveThemeState(themeState);
  }
}
