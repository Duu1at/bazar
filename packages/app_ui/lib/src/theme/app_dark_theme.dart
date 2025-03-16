import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

@immutable
final class AppDarkTheme extends AppTheme {
  const AppDarkTheme();

  @override
  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.black,
      splashColor: AppColors.transparent,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
      dividerTheme: dividerTheme,
      inputDecorationTheme: inputDecorationTheme,
      buttonTheme: buttonTheme,
      snackBarTheme: snackBarTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      colorScheme: colorScheme,
      bottomSheetTheme: bottomSheetTheme,
      listTileTheme: listTileTheme,
      switchTheme: switchTheme,
      progressIndicatorTheme: progressIndicatorTheme,
      tabBarTheme: tabBarTheme,
      bottomNavigationBarTheme: bottomAppBarTheme,
      chipTheme: chipTheme,
      scaffoldBackgroundColor: colorScheme.onPrimary,
    );
  }

  @override
  TextTheme get primaryTextTheme {
    return const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(
      displayColor: AppColors.white,
      bodyColor: AppColors.white,
    );
  }

  @override
  TextTheme get textTheme {
    return const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(
      displayColor: AppColors.white,
      bodyColor: AppColors.white,
    );
  }

  @override
  ColorScheme get colorScheme {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.white,
      onPrimary: Color(0xFF080808),
      primaryContainer: Color(0xFF404040),
      onPrimaryContainer: Color(0xFFF7F7F7),
      primaryFixed: Color(0xFFC9C9C9),
      primaryFixedDim: Color(0xFF9F9F9F),
      onPrimaryFixed: Color(0xFF000000),
      onPrimaryFixedVariant: Color(0xFF000000),
      secondary: AppColors.blue,
      onSecondary: AppColors.secondary,
      secondaryContainer: Color(0xFF474747),
      onSecondaryContainer: Color(0xFFF7F7F7),
      secondaryFixed: Color(0xFFC9C9C9),
      secondaryFixedDim: Color(0xFF9F9F9F),
      onSecondaryFixed: Color(0xFF000000),
      onSecondaryFixedVariant: Color(0xFF000000),
      tertiary: AppColors.white,
      onTertiary: Color(0xFF080808),
      tertiaryContainer: Color(0xFF5E5E5E),
      onTertiaryContainer: Color(0xFFF8F8F8),
      tertiaryFixed: Color(0xFFC9C9C9),
      tertiaryFixedDim: Color(0xFF9F9F9F),
      onTertiaryFixed: Color(0xFF000000),
      onTertiaryFixedVariant: Color(0xFF000000),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF080707),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFCF3F3),
      surface: Color(0xFF171717),
      onSurface: Color(0xFFF0F0F0),
      surfaceDim: Color(0xFF161616),
      surfaceBright: Color(0xFF393939),
      surfaceContainerLowest: Color(0xFF111111),
      surfaceContainerLow: Color(0xFF1D1D1D),
      surfaceContainer: Color(0xFF242424),
      surfaceContainerHigh: Color(0xFF2B2B2B),
      surfaceContainerHighest: Color(0xFF353535),
      onSurfaceVariant: Color(0xFFCCCCCC),
      outline: Color(0xFF808080),
      outlineVariant: Color(0xFF4D4D4D),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE9E9E9),
      onInverseSurface: Color(0xFF303030),
      inversePrimary: Color(0xFF747474),
      surfaceTint: AppColors.white,
    );
  }
}
