import 'package:flutter/material.dart';

class Pink {

  static Color primary = Colors.grey.shade700;
  static const Color disabled = Colors.grey;
  static const Color hintColor = Colors.purpleAccent;
  static const Color primaryLight = Colors.white;
  static const Color textColor = Colors.pink;
  static const Color bkgroundAppBar = Colors.pink;
  static Color scaffBkg = Colors.pink.shade100;
  static Color dlgBkg = Colors.pink.shade100;
  static const Color iconColor = Colors.pinkAccent;
  static const Color bottNavBarBkg = Colors.pink;
  static const Color expTileThemIconColor = Colors.pink;
  static const Color dividerColor = Colors.pink;
  static const Color unselIconColor = Colors.white70;


  static final ThemeData themeData = ThemeData.dark().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    iconTheme: const IconThemeData(color: Pink.iconColor),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Pink.expTileThemIconColor
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Pink.textColor ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Pink.textColor),
      bodyMedium: TextStyle(color: Pink.textColor),
      bodySmall: TextStyle(color: Pink.textColor),
      displayLarge: TextStyle(color: Pink.textColor),
      displayMedium: TextStyle(color: Pink.textColor),
      displaySmall: TextStyle(color: Pink.textColor),
    ),

    dividerColor: Pink.dividerColor,

    scaffoldBackgroundColor: Pink.scaffBkg,

    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Pink.bkgroundAppBar,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Pink.dlgBkg,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Pink.primary,
          shape: const StadiumBorder(),
          elevation: 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pink.bottNavBarBkg,
      unselectedItemColor: Pink.unselIconColor,
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