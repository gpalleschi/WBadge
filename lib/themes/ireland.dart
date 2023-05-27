import 'package:flutter/material.dart';

class Ireland {

  static Color primary = Colors.grey.shade700;
  static const Color disabled = Colors.grey;
  static Color hintColor = Colors.orange.shade700;
  static const Color primaryLight = Colors.white;
  static const Color textColor = Color.fromRGBO(0, 154, 68, 1);
  static const Color bkgroundAppBar = Colors.orange;
  static Color scaffBkg = Colors.orange.shade200;
  static Color dlgBkg = Colors.orange.shade200;
  static const Color iconColor = Color.fromRGBO(0, 154, 68, 1);
  static const Color bottNavBarBkg = Colors.orange;
  static const Color expTileThemIconColor = Color.fromRGBO(0, 154, 68, 1);
  static const Color dividerColor = Color.fromRGBO(0, 154, 68, 1);
  static const Color unselIconColor = Colors.white70;


  static final ThemeData themeData = ThemeData.light().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    iconTheme: const IconThemeData(color: Ireland.iconColor),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: scaffBkg,
      dialTextColor: textColor,
      dialHandColor: Colors.orange.shade400,
      hourMinuteColor: Colors.orange.shade400,
      hourMinuteTextColor: textColor,
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Ireland.expTileThemIconColor
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Ireland.textColor ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Ireland.textColor),
      bodyMedium: TextStyle(color: Ireland.textColor),
      bodySmall: TextStyle(color: Ireland.textColor),
      displayLarge: TextStyle(color: Ireland.textColor),
      displayMedium: TextStyle(color: Ireland.textColor),
      displaySmall: TextStyle(color: Ireland.textColor),
    ),

    dividerColor: Ireland.dividerColor,

    scaffoldBackgroundColor: Ireland.scaffBkg,

    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Ireland.bkgroundAppBar,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Ireland.dlgBkg,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Ireland.primary,
          shape: const StadiumBorder(),
          elevation: 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Ireland.bottNavBarBkg,
      unselectedItemColor: Ireland.unselIconColor,
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