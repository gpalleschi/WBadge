import 'package:flutter/material.dart';

class Tim {

  static Color primary = Colors.grey.shade700;
  static const Color disabled = Colors.grey;
  static Color hintColor = Color.fromRGBO(253,0,40,1);
  static const Color primaryLight = Colors.white;
  static const Color textColor = Color.fromRGBO(8, 22, 119, 1);
  static const Color bkgroundAppBar = Color.fromRGBO(253,0,40,1);
  static Color scaffBkg = Colors.white;
  static Color dlgBkg = Colors.white;
  static const Color iconColor = Color.fromRGBO(8, 22, 119, 1);
  static const Color bottNavBarBkg = Color.fromRGBO(253,0,40,1);
  static const Color expTileThemIconColor = Color.fromRGBO(253,0,40,1);
  static const Color dividerColor = Color.fromRGBO(253,0,40,1);
  static const Color unselIconColor = Colors.white70;


  static final ThemeData themeData = ThemeData.dark().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    iconTheme: const IconThemeData(color: Tim.iconColor),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Tim.expTileThemIconColor
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Tim.textColor ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Tim.textColor),
      bodyMedium: TextStyle(color: Tim.textColor),
      bodySmall: TextStyle(color: Tim.textColor),
      displayLarge: TextStyle(color: Tim.textColor),
      displayMedium: TextStyle(color: Tim.textColor),
      displaySmall: TextStyle(color: Tim.textColor),
    ),

    dividerColor: Tim.dividerColor,

    scaffoldBackgroundColor: Tim.scaffBkg,

    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Tim.bkgroundAppBar,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Tim.dlgBkg,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Tim.primary,
          shape: const StadiumBorder(),
          elevation: 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Tim.bottNavBarBkg,
      unselectedItemColor: Tim.unselIconColor,
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