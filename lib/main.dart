import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ufcat_app/shared/splash.dart';
import 'package:ufcat_app/theme/theme.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serviços UFCAT',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        primarySwatch: greenUfcat,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: greenUfcat,
        //   backgroundColor: greenUfcat,
        //   accentColor: greenUfcat,
        //   cardColor: greenUfcat,
        // ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // useMaterial3: true,
        fontFamily: 'Rawline', // fontstyle
        textTheme: textTheme(),
      ),
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      home: const SplashScreen(),
    );
  }
}
