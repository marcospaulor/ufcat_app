import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ufcat_app/features/home/pages/home_screen.dart';

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

    if (mounted) { // Verifica se o widget ainda está na árvore antes de atualizar o estado
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

  @override
  Widget build(BuildContext context) {
    if (isActive == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (isActive == false) {
      return const TestVersionScreen();
    }
    return AnimatedSplashScreen(
      duration: 5500,
      splash: Stack(
        children: <Widget>[
          RotationTransition(
            turns: _animation,
            child: Image.asset('assets/images/letras_logo.png'),
          ),
          Image.asset('assets/images/logo_logo.png'),
        ],
      ),
      splashIconSize: 200,
      nextScreen: const HomeView(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}

class TestVersionScreen extends StatelessWidget {
  const TestVersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                "Versão de Teste Expirada",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Esta versão do aplicativo era apenas para testes e não está mais disponível. Recomendamos que desinstale o aplicativo.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => exit(0),
                child: const Text("Fechar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
