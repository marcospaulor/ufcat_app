import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/components/splash.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/style/fontsStyle.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true;

    return MaterialApp(
      title: 'UFCAT',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        primarySwatch: greenUfcat,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Rawline',
        // fontstyle
        textTheme: textTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
