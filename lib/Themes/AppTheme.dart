import 'package:flutter/material.dart';

import 'AppColors.dart';
import './AppTextStyle.dart';
import './AppStrings.dart';

class AppTheme {
  // Define the theme data for your app
  static final ThemeData lightTheme = ThemeData(
    // Define the primary color palette
    primaryColor: primary100,
    scaffoldBackgroundColor: bg100,

    // accentColor: accent100,
    // colorScheme: const ColorScheme.light().copyWith(
    //   // brightness: Brightness.light,
    //   background: bg100,
    // ),
    hintColor: text200,
    appBarTheme: const AppBarTheme(
      elevation: 3,
      centerTitle: true,
      color: bg200,
      titleTextStyle: AppTextStyles.headingTextStyle,
      iconTheme: IconThemeData(
        color: primary100,
      ),
      actionsIconTheme: IconThemeData(
        color: primary100,
      ),
    ),

    // Define the text theme
    textTheme: const TextTheme(
        headlineLarge: AppTextStyles.headingTextStyle,
        headlineMedium: AppTextStyles.subheadingTextStyle,
        bodyMedium: AppTextStyles.bodyTextStyle),

    // Define button themes
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: primary200,
    //     textStyle: AppTextStyles.buttonTextStyle,
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     backgroundColor: primary200,
    //     textStyle: AppTextStyles.buttonTextStyle,
    //   ),
    // ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Define the dark theme data if needed
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      // Define the primary color palette for dark mode
      primaryColor: primary100);
}
