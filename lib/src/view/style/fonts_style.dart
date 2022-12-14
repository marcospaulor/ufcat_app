// function that returns a texttheme
import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/style/const.dart';

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
    ),
  );
}
