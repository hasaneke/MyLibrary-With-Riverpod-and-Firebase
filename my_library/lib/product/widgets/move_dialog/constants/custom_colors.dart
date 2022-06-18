import 'package:flutter/material.dart';

abstract class Palette {
  static final Color kyellowPrimaryColor =
      Color(Colors.yellow[200]!.value.toInt());
  // static final colorbuttons = [
  //   const Color(4294961979),
  //   const Color(4294198070),
  //   const Color(4294940672),
  //   const Color(4280391411),
  // ];
  static final Map<String, Color> colorButtons = {
    'yellow': const Color(0xccfada5e),
    'red': const Color(0xcced2939),
    'orange': const Color(0xccffa500),
    'blue': const Color(0xcc58cced),
    'green': const Color(0xcc50c878),
    'black': const Color(0xcc0f0c08),
  };
}
//0xfffada5e
