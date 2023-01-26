import 'dart:io';
import 'package:ufcat_app/android/app.dart';
import 'package:ufcat_app/ios/app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  initializeDateFormatting().then((_) =>
      Platform.isAndroid ? runApp(const AndroidApp()) : runApp(const IOSApp()));
}
