import 'package:flutter/material.dart';

class Dark {

  static Color primary = Colors.grey.shade700;
  static const Color disabled = Colors.grey;
  static const Color hintColor = Colors.red;
  static const Color primaryLight = Colors.white;
  static const Color textColor = Colors.white;
  static const Color bkgroundAppBar = Color.fromRGBO(117, 117, 117, 1);
  static Color scaffBkg = Colors.grey.shade800;
  static Color dlgBkg = scaffBkg;
  static const Color iconColor = Color.fromARGB(255, 65, 155, 229);
  static const Color bottNavBarBkg = Color.fromRGBO(117, 117, 117, 1);
  static const Color expTileThemIconColor = Colors.white;
  static const Color dividerColor = Colors.grey;
  static const Color unselIconColor = Colors.white70;

  static final ThemeData themeData = ThemeData.dark().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    timePickerTheme: TimePickerThemeData(
      backgroundColor: scaffBkg,
    ),

    iconTheme: const IconThemeData(color: Dark.iconColor),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Dark.expTileThemIconColor
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Dark.textColor ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Dark.textColor),
      bodyMedium: TextStyle(color: Dark.textColor),
      bodySmall: TextStyle(color: Dark.textColor),
      displayLarge: TextStyle(color: Dark.textColor),
      displayMedium: TextStyle(color: Dark.textColor),
      displaySmall: TextStyle(color: Dark.textColor),
    ),

    dividerColor: Dark.dividerColor,

    scaffoldBackgroundColor: Dark.scaffBkg,

    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Dark.bkgroundAppBar,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Dark.dlgBkg,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Dark.primary,
          shape: const StadiumBorder(),
          elevation: 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Dark.bottNavBarBkg,
      unselectedItemColor: Dark.unselIconColor,
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