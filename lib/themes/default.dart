import 'package:flutter/material.dart';

class Default {

  static const Color primary = Colors.indigo;
  static const Color disabled = Colors.grey;
  static Color hintColor = Colors.red;
  static const Color primaryLight = Colors.white;

  static Color hMColor = Colors.indigo;

  static final ThemeData themeData = ThemeData.light().copyWith(
    primaryColor: primary,
    disabledColor: disabled,
    primaryColorLight: primaryLight,
    hintColor: hintColor,

    iconTheme: const IconThemeData(color: primary),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.grey[300],
      dialTextColor: primary,
      //dialHandColor: Colors.indigo,
      hourMinuteColor: hMColor,
      //hourMinuteTextColor: primary,
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primary 
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: primary),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: primary),
      bodyMedium: TextStyle(color: primary),
      bodySmall: TextStyle(color: primary),
      displayLarge: TextStyle(color: primary),
      displayMedium: TextStyle(color: primary),
      displaySmall: TextStyle(color: primary),
    ),

    dividerColor: primary,

    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Default.primary,
          scrolledUnderElevation: 2
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Default.primary,
          elevation: 2 
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        //backgroundColor: primary,
        foregroundColor: primary,
        textStyle: const TextStyle(fontWeight: FontWeight.bold ),
        side: const BorderSide(color: primary, width: 3),
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Default.primary,
//          shape: const StadiumBorder(),
//          elevation: 0
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primary,
      unselectedItemColor: Colors.white70,
      elevation: 5,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    ),
  );
}