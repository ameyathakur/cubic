import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'RegisterScreen.dart';
import 'loginPage.dart';
import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _Splashscreenstate createState() => _Splashscreenstate();

}


class _Splashscreenstate extends State<SplashScreen> with TickerProviderStateMixin {


  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    Firebase.initializeApp();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);
    _animationController.repeat(reverse: true);
  }


  void timer()async{
    Firebase.initializeApp();
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    Timer(const Duration(seconds: 5), () async {

      User? user=FirebaseAuth.instance.currentUser;
      if (user == null) {

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => login()));

      } else {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MainScreen()));

      }
      // Navigator.of(context)
      //      .pushReplacement(MaterialPageRoute(builder: (context) => login()));
      //     Fluttertoast.showToast(msg:"New User",gravity:ToastGravity.BOTTOM);
    }
    );
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
    timer();
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
