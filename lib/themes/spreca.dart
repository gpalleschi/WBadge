import 'package:flutter/material.dart';

class Spreca {

  static Color primary = Colors.grey.shade700;
  static const Color disabled = Colors.black;
  static Color hintColor = Color.fromRGBO(253,0,40,1);
  static const Color primaryLight = Colors.white;
  static const Color textColor = Colors.black;
  static const Color bkgroundAppBar = Color.fromRGBO(26, 35, 126, 1);
  static Color scaffBkg = Colors.grey.shade200;
  static Color dlgBkg = Colors.white;
  static const Color iconColor = Color.fromRGBO(118, 255, 3, 1);
  static const Color bottNavBarBkg = Colors.red;
  static const Color expTileThemIconColor = Colors.orangeAccent;
  static const Color dividerColor = Colors.grey;
  static const Color unselIconColor = Colors.white70;


  static final ThemeData themeData = ThemeData.light().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    iconTheme: const IconThemeData(color: Spreca.iconColor),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: scaffBkg,
      dialTextColor: textColor,
      dialHandColor: Spreca.iconColor,
      hourMinuteColor: Spreca.iconColor,
      hourMinuteTextColor: Colors.black,
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Spreca.expTileThemIconColor
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Spreca.textColor ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Spreca.textColor),
      bodyMedium: TextStyle(color: Spreca.textColor),
      bodySmall: TextStyle(color: Spreca.textColor),
      displayLarge: TextStyle(color: Spreca.textColor),
      displayMedium: TextStyle(color: Spreca.textColor),
      displaySmall: TextStyle(color: Spreca.textColor),
    ),

    dividerColor: Spreca.dividerColor,

    scaffoldBackgroundColor: Spreca.scaffBkg,

    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Spreca.bkgroundAppBar,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Spreca.dlgBkg,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Spreca.primary,
          shape: const StadiumBorder(),
          elevation: 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Spreca.bottNavBarBkg,
      unselectedItemColor: Spreca.unselIconColor,
      elevation: 5,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    ),
  );
}