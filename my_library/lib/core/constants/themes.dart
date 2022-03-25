import 'package:flutter/material.dart';
import 'package:my_library/core/fonts/font_styles.dart';

abstract class Themes {
  /* LIME THEME */
  static final limetheme = ThemeData(
    popupMenuTheme: PopupMenuThemeData(
        textStyle: const TextStyle(color: Colors.black, fontSize: 15),
        color: Colors.lime[50]),
    hintColor: Colors.black38,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.lime[50],
    ),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.white24,
        unselectedIconTheme: IconThemeData(color: Colors.white24)),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.lime[50], foregroundColor: Colors.black),
    fontFamily: FontStyles.selectedFont,
    unselectedWidgetColor: Colors.black45,
    selectedRowColor: Colors.red,
    scaffoldBackgroundColor: Colors.lime[50],
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(6),
      minimumSize: MaterialStateProperty.all<Size>(const Size(90, 40)),
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.lime[50] ?? Colors.red),
    )),
    backgroundColor: Colors.white,
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black, fontSize: 20),
        bodyText2: TextStyle(color: Colors.black, fontSize: 15),
        subtitle1: TextStyle(color: Colors.black, fontSize: 15),
        overline: TextStyle(color: Colors.black, fontSize: 11)),
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black87,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
  );
  /* DARK THEME */
  static final darkTheme = ThemeData(
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    popupMenuTheme: const PopupMenuThemeData(
        color: Color.fromARGB(255, 71, 64, 64),
        textStyle: TextStyle(color: Colors.white, fontSize: 14)),
    hintColor: Colors.white,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 71, 64, 64),
        scrimColor: Color.fromARGB(255, 71, 64, 64)),
    buttonTheme:
        const ButtonThemeData(buttonColor: Color.fromARGB(255, 71, 64, 64)),
    dialogTheme:
        const DialogTheme(backgroundColor: Color.fromARGB(255, 71, 64, 64)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.white)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black, foregroundColor: Colors.white),
    fontFamily: FontStyles.selectedFont,
    unselectedWidgetColor: Colors.black45,
    selectedRowColor: Colors.red,
    scaffoldBackgroundColor: Colors.black54,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(8),
      minimumSize: MaterialStateProperty.all<Size>(const Size(90, 40)),
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 71, 64, 64)),
    )),
    backgroundColor: const Color.fromARGB(255, 71, 64, 64),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white, fontSize: 20),
        bodyText2: TextStyle(color: Colors.white, fontSize: 15),
        subtitle1: TextStyle(color: Colors.black54, fontSize: 15),
        overline: TextStyle(color: Colors.white, fontSize: 11)),
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.white54),
  );
}
