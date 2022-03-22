import 'dart:async';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _Splashscreenstate createState() => _Splashscreenstate();
}

class _Splashscreenstate extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => login()));
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);
    _animationController.repeat(reverse: true);
  }

  late final AnimationController _animationController;
  late Animation<double> _animation;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  late final Animation<Offset> _leftToRightAnim = Tween<Offset>(
    begin: const Offset(-1.5, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  late final Animation<Offset> _rightToLeftAnim = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1ECEC),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset('Assets/Logo.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SlideTransition(
                  position: _leftToRightAnim,
                  child: const Text('SIMPLIFY|TRANSFORM|OUTPERFORM'),
                ),
                SlideTransition(
                  position: _rightToLeftAnim,
                  child: const Text('APP BY TRANSEUNT'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
