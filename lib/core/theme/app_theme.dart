import 'package:flutter/material.dart';
import 'package:peqing/core/theme/app_colors.dart';

class AppTheme {
  ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary[500],
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch:
            MaterialColor(AppColors.primary[500]!.value, AppColors.primary),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static TextStyle textStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color,
      decoration: TextDecoration.none,
      fontFamily: 'Plus Jakarta Sans',
      fontSize: fontSize,
      fontWeight: fontWeight,
      textBaseline: TextBaseline.alphabetic,
    );
  }

  TextTheme get _textTheme {
    return TextTheme(
      titleLarge: textStyle(
        color: AppColors.dark[500],
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: textStyle(
        color: AppColors.dark[500],
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: textStyle(
        color: AppColors.dark[500],
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: textStyle(
        color: AppColors.dark[500],
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: textStyle(
        color: AppColors.dark[500],
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: textStyle(
        color: AppColors.dark[300],
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: BorderSide(color: AppColors.dark[100]!, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: BorderSide(color: AppColors.dark[100]!, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: BorderSide(color: AppColors.primary[500]!, width: 2.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primary[500]!),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        padding:
            WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16.0)),
        textStyle: WidgetStateProperty.all(
          textStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
