import 'dart:async';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'MainScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => login())));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF1ECEC),
        body: Center(
          child: Image.asset('Assets/Logo.png'),
        ),
      ),
    );
  }
}
