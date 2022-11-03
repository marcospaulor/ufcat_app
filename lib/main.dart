import 'package:flutter/material.dart';
import 'view/components/splash.dart';
import 'package:ufcat_app/view/const.dart';

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
        fontFamily: 'Rawline',
        primarySwatch: greenUfcat,
      ),
      home: const SplashScreen(),
    );
  }
}
