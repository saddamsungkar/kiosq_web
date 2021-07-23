import 'dart:ui';

import 'package:flutter/material.dart';

String keyString(Key key){
  return key.toString().replaceAll("[<'", '').replaceAll("'>]", '');
}

class Static {
  static bool headerState = false;
  static bool sidebarState = false;
  static double sidebarStart = 1;
  static double sidebarEnd = 1;
  static double headerStart = 0;
  static double headerEnd = 0;
  static ScrollController scrollController;
  static Function hideSidebarCallback;
}

class _Text {
  TextStyle header;
}

class Styles {

  static final _Text text = _Text();

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  static final Color primary = hexToColor('#387EF5');
  static final Color secondary = hexToColor('#FFD300');
  static final Color white = Colors.white;
  static final Color primaryAccent = hexToColor('#809EFF');
  static final Color secondaryAccent = hexToColor('#E5E5E5');
  static final ButtonStyle headerBtnStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Colors.black;
          else if (states.contains(MaterialState.hovered)) return primary;
          return Colors.black;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return primaryAccent;
          else if (states.contains(MaterialState.hovered))
            return secondaryAccent;
          return null;
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50))));
}