import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_project/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  indicatorColor: defaultColor,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.redAccent,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.red, statusBarIconBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Fabrica',
);

ThemeData lightTheme = ThemeData(
  primaryColor: defaultColor,
  focusColor: Colors.deepOrange,
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.redAccent,
    ),
        titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.red, statusBarIconBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: defaultColor)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defaultColor)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defaultColor)
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Fabrica',
);
