import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ufcat_app/shared/splash.dart';
import 'package:ufcat_app/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  initializeDateFormatting().then((_) => {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    runApp(const MyApp())
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFCAT Serviços',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        primarySwatch: greenUfcat,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
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
