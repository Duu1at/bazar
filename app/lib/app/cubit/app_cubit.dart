import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit(this.appThemeRepository) : super(appThemeRepository.getInitialThemeState());

  final AppRepository appThemeRepository;

  Future<void> changeMode({required bool isDark}) async {
    await appThemeRepository.saveThemeMode(isDark: isDark);
    if (isDark) {
      emit(const AppDarkTheme());
    } else {
      emit(const AppLightTheme());
    }
  }
}
