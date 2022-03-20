import 'package:flutter/material.dart';
import 'package:my_library/core/fonts/font_styles.dart';

abstract class Themes {
  static final limetheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.lime[50]),
    fontFamily: FontStyles.selectedFont,
    popupMenuTheme: PopupMenuThemeData(
        textStyle: const TextStyle(color: Colors.black, fontSize: 15),
        color: Colors.lime[50]),
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
}
