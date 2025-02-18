import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

@immutable
final class AppLightTheme extends AppTheme {
  const AppLightTheme();

  @override
  ColorScheme get colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.black,
      onPrimary: AppColors.white,
      primaryContainer: Color(0xFFE0E0E0),
      onPrimaryContainer: Color(0xFF131313),
      primaryFixed: Color(0xFFC9C9C9),
      primaryFixedDim: Color(0xFF9F9F9F),
      onPrimaryFixed: AppColors.black,
      onPrimaryFixedVariant: AppColors.black,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      secondaryContainer: Color(0xFFE4E4E4),
      onSecondaryContainer: Color(0xFF131313),
      secondaryFixed: Color(0xFFC9C9C9),
      secondaryFixedDim: Color(0xFF9F9F9F),
      onSecondaryFixed: AppColors.black,
      onSecondaryFixedVariant: AppColors.black,
      tertiary: AppColors.black,
      onTertiary: AppColors.white,
      tertiaryContainer: Color(0xFFC9C9C9),
      onTertiaryContainer: Color(0xFF111111),
      tertiaryFixed: Color(0xFFC9C9C9),
      tertiaryFixedDim: Color(0xFF9F9F9F),
      onTertiaryFixed: AppColors.black,
      onTertiaryFixedVariant: AppColors.black,
      error: Color(0xFFBA1A1A),
      onError: AppColors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF141312),
      surface: Color(0xFFF8F8F8),
      onSurface: Color(0xFF141414),
      surfaceDim: Color(0xFFDCDCDC),
      surfaceBright: Color(0xFFF9F9F9),
      surfaceContainerLowest: Color(0xFFFBFBFB),
      surfaceContainerLow: Color(0xFFF4F4F4),
      surfaceContainer: Color(0xFFEFEFEF),
      surfaceContainerHigh: Color(0xFFE9E9E9),
      surfaceContainerHighest: Color(0xFFE3E3E3),
      onSurfaceVariant: Color(0xFF393939),
      outline: Color(0xFF868686),
      outlineVariant: Color(0xFFC1C1C1),
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: Color(0xFF2A2A2A),
      onInverseSurface: Color(0xFFEAEAEA),
      inversePrimary: Color(0xFF808080),
      surfaceTint: AppColors.black,
    );
  }

  @override
  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.white,
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
    return TextTheme(
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
      displayColor: AppColors.black,
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
      displayColor: AppColors.black,
      bodyColor: AppColors.black,
    );
  }
}
