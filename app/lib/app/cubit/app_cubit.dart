import 'package:app/core/constants/constants.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_storage/mb_storage.dart';

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit(this.storage) : super(const AppDarkTheme());

  final MbStorage storage;

  AppTheme initialTheme() {
    final isDark = storage.readBool(key: SharedKeys.mode);
    if (isDark != null && isDark) {
      return const AppDarkTheme();
    } else {
      return const AppLightTheme();
    }
  }

  Future<void> changeMode({required bool isDark}) async {
    await storage.writeBool(key: SharedKeys.mode, value: isDark);
    if (isDark) {
      emit(const AppDarkTheme());
    } else {
      emit(const AppLightTheme());
    }
  }
}
