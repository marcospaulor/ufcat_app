import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/components/splash.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/style/fontsStyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFCAT',
      theme: ThemeData(
        primarySwatch: greenUfcat,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        fontFamily: 'Rawline',
        appBarTheme: ,
        // fontstyle
        textTheme: textTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
