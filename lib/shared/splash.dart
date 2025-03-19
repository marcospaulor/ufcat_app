import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ufcat_app/features/home/pages/home_screen.dart';
import 'package:ufcat_app/shared/test_v_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 3500),
    vsync: this,
  )..repeat();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
  );

  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref("/active");
  bool? isActive;

  @override
  void initState() {
    super.initState();
    _checkAppStatus();
  }

  void _checkAppStatus() {
    _databaseRef.onValue.listen((event) {
      final active = event.snapshot.value as bool?;
      if (mounted) {
        setState(() {
          isActive = active;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSplashContent() {
    return Stack(
      children: <Widget>[
        RotationTransition(
          turns: _animation,
          child: Image.asset('assets/images/letras_logo.png'),
        ),
        Image.asset('assets/images/logo_logo.png'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Se isActive for null, mostra apenas a splash screen sem transição
    if (isActive == null) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: _buildSplashContent(),
          ),
        ),
      );
    }

    // Quando isActive tiver um valor, usa AnimatedSplashScreen para transição
    return AnimatedSplashScreen(
      duration: 1000, // Reduz o tempo para uma transição mais rápida após validação
      splash: _buildSplashContent(),
      splashIconSize: 200,
      nextScreen: isActive == true ? const HomeView() : const TestVersionScreen(),
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}