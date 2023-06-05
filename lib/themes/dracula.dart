import 'package:flutter/material.dart';

class Dracula {

  static Color primary = Colors.grey.shade700;
  static Color disabled = Colors.grey;
  static Color hintColor = Colors.purple;
  static Color primaryLight = Colors.white;

  static final ThemeData themeData = ThemeData.dark().copyWith(

    //primaryColor: primary,
    disabledColor: disabled, 
    hintColor: hintColor,
    primaryColorLight: primaryLight,

    iconTheme: const IconThemeData(color: Color.fromRGBO(138, 3, 3, 1)),

     timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.purple.shade100,
      dialTextColor: Colors.black,
      dialHandColor: Colors.purple,
      hourMinuteColor: Colors.black,
      hourMinuteTextColor: hintColor,
      dayPeriodColor: Colors.grey,
      dayPeriodTextColor: Colors.purple
      //dialBackgroundColor: Color.fromRGBO(158, 158, 158, 1),
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Colors.black
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.black),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
    ),

    dividerColor: Colors.black,

    scaffoldBackgroundColor: Colors.purple.shade100,
    appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.purple,
          scrolledUnderElevation: 2
        ),

    dialogBackgroundColor: Colors.purple.shade100,

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        //backgroundColor: primary,
        foregroundColor:  const Color.fromRGBO(138, 3, 3, 1),
        textStyle: const TextStyle(fontWeight: FontWeight.bold ),
        side: const BorderSide(color: Colors.black, width: 3),
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          // shape: const StadiumBorder(),
          // elevation: 0
          ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.purple,
      unselectedItemColor: Colors.white70,
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