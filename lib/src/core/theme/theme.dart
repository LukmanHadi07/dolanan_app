// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/core/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final baseButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    disabledBackgroundColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
);

extension ThemeDataExtension on ThemeData {
  static final Map<InputDecorationTheme, DolananThemeData> posTheme = {};
  static DolananThemeData empty = DolananThemeData.empty();

  DolananThemeData get appTheme {
    return posTheme[inputDecorationTheme] ?? empty;
  }

  ThemeData setAppTheme(DolananThemeData theme) {
    posTheme[inputDecorationTheme] = theme;
    return this;
  }
}

ThemeData dolananNewTheme(bool dark) {
  if (dark) {
    return ThemeData.dark()
        .copyWith(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: AppColors.primaryColor,
          textTheme: createTextTheme(textTheme, Colors.black),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          colorScheme: const ColorScheme.dark().copyWith(
            primary: AppColors.primaryColor,
          ),
        )
        .setAppTheme(DolananThemeData.light());
  }

  return ThemeData.light()
      .copyWith(
          brightness: Brightness.light,
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: createTextTheme(textTheme, Colors.black),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColors.primaryColor,
          ))
      .setAppTheme(DolananThemeData.dark());
}

TextTheme createTextTheme(TextTheme textTheme, Color color) {
  return textTheme.copyWith(
    displayLarge: textTheme.displayLarge?.copyWith(color: color),
    displayMedium: textTheme.displayMedium?.copyWith(color: color),
    displaySmall: textTheme.displaySmall?.copyWith(color: color),
    headlineLarge: textTheme.headlineLarge?.copyWith(color: color),
    headlineMedium: textTheme.headlineMedium?.copyWith(color: color),
    headlineSmall: textTheme.headlineSmall?.copyWith(color: color),
    labelLarge: textTheme.labelLarge?.copyWith(color: color),
    labelMedium: textTheme.labelMedium?.copyWith(color: color),
    labelSmall: textTheme.labelSmall?.copyWith(color: color),
  );
}

ElevatedButtonThemeData createButtonTheme(
    ElevatedButtonThemeData buttonTheme, Color color, Color textColor) {
  return ElevatedButtonThemeData(
    style: buttonTheme.style?.copyWith(
      backgroundColor: WidgetStatePropertyAll(color),
      foregroundColor: WidgetStatePropertyAll(textColor),
      textStyle: WidgetStatePropertyAll(
        TextStyle(color: textColor, fontSize: 12),
      ),
    ),
  );
}

class DolananThemeData {
  final TextTheme primaryTextTheme;

  final Color primaryColor;

  final ElevatedButtonThemeData primaryButtonTheme;

  const DolananThemeData({
    required this.primaryTextTheme,
    required this.primaryColor,
    required this.primaryButtonTheme,
  });

  static light() {
    return DolananThemeData(
      primaryColor: AppColors.primaryColor,

      // thirdColor: thirdColorTheme,
      primaryTextTheme: createTextTheme(textTheme, Colors.white),

      // thirdTextTheme: createTextTheme(baseTextTheme, thirdColorTheme),
      primaryButtonTheme: createButtonTheme(
          baseButtonTheme, AppColors.primaryColor, Colors.black),

      // innactiveButtonTheme:
      //     createButtonTheme(baseButtonTheme, buttonInactiveColor, Colors.black),
    );
  }

  static dark() {
    return DolananThemeData(
      primaryColor: AppColors.primaryColor,

      // thirdColor: thirdColorTheme,
      primaryTextTheme: createTextTheme(textTheme, Colors.black),

      // thirdTextTheme: createTextTheme(baseTextTheme, thirdColorTheme),
      primaryButtonTheme: createButtonTheme(
          baseButtonTheme, AppColors.primaryColor, Colors.black),

      // innactiveButtonTheme:
      //     createButtonTheme(baseButtonTheme, buttonInactiveColor, Colors.black),
    );
  }

  static empty() {
    return DolananThemeData.light();
  }
}
