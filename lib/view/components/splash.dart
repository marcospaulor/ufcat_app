import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ufcat_app/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      milliseconds: 1500,
    ),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      duration: 2500,
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
      // nextScreen: const HomeView(),
      screenFunction: () async {
        await Future.delayed(const Duration(milliseconds: 2500));
        return const HomeView();
      },
    );
  }
}
