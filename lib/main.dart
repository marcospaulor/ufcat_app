import 'package:flutter/material.dart';
import 'view/components/splash.dart';
import 'package:ufcat_app/view/home.dart';
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
      title: 'Ufcat App',
      theme: ThemeData(
        fontFamily: 'Rawline',
        primarySwatch: greenUfcat,
      ),
      home: const HomeView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
