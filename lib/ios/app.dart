import 'package:flutter/cupertino.dart';
import 'package:ufcat_app/src/view/components/splash.dart';

class IOSApp extends StatelessWidget {
  const IOSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'UFCAT',
      home: SplashScreen(),
    );
  }
}
