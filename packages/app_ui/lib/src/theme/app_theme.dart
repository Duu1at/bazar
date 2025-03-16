import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme();

  ThemeData get themeData;

  ColorScheme get colorScheme;

  TextTheme get textTheme;

  TextTheme get primaryTextTheme;

  AppBarTheme get appBarTheme {
    return AppBarTheme(
      centerTitle: true,
      color: colorScheme.surface,
    );
  }

  SnackBarThemeData get snackBarTheme {
    return const SnackBarThemeData();
  }

  IconThemeData get iconTheme {
    return const IconThemeData();
  }

  DividerThemeData get dividerTheme {
    return const DividerThemeData();
  }

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme();
  }

  ButtonThemeData get buttonTheme {
    return const ButtonThemeData();
  }

  ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 52),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        textStyle: primaryTextTheme.titleMedium?.copyWith(fontSize: 18),
      ),
    );
  }

  OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.primary),
        fixedSize: const Size.fromHeight(50),
        iconColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        textStyle: primaryTextTheme.titleMedium?.copyWith(fontSize: 18),
      ),
    );
  }

  TextButtonThemeData get textButtonTheme {
    return const TextButtonThemeData();
  }

  BottomSheetThemeData get bottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      dragHandleSize: const Size(58, 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  ListTileThemeData get listTileTheme {
    return const ListTileThemeData();
  }

  SwitchThemeData get switchTheme {
    return SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => AppColors.transparent,
      ),
    );
  }

  ProgressIndicatorThemeData get progressIndicatorTheme {
    return const ProgressIndicatorThemeData();
  }

  TabBarTheme get tabBarTheme {
    return const TabBarTheme();
  }

  InputBorder get textFieldBorder {
    return const OutlineInputBorder();
  }

  BottomNavigationBarThemeData get bottomAppBarTheme {
    return BottomNavigationBarThemeData(
      selectedItemColor: colorScheme.secondary,
      selectedIconTheme: IconThemeData(
        color: colorScheme.secondary,
        size: 30,
      ),
      unselectedItemColor: colorScheme.outline,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  ChipThemeData get chipTheme {
    return const ChipThemeData();
  }
}
