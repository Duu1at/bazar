import 'package:app_ui/src/repo/repo.dart';
import 'package:flutter/material.dart';

@immutable
final class LocalThemeDataSourceMock implements LocalThemeDataSource {
  const LocalThemeDataSourceMock();

  @override
  ReadThemeData getInitialThemeState() {
    return ReadThemeData.initial;
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return Future.value();
  }
}
