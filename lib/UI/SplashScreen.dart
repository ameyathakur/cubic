import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/UI/PaymentScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Custom Models/MemberModel.dart';
import 'RegisterScreen.dart';
import 'loginPage.dart';
import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _Splashscreenstate createState() => _Splashscreenstate();
}

class _Splashscreenstate extends State<SplashScreen>
    with TickerProviderStateMixin {
  List<MemberModel> membersi = [];
  late int number;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);
    _animationController.repeat(reverse: true);
  }

  void timer() async {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    await getState().then((value) =>
    Timer(const Duration(seconds: 5), () async {

      switch(number) {
        case 1: {
          Navigator.of(context)
               .pushReplacement(MaterialPageRoute(builder: (context) => login()));

        }
        break;

        case 2: {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen()));
        }
        break;

        case 3: {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => PaymentScreen()));
        }
        break;

        case 4: {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
        }

        break;

      }
      // Navigator.of(context)
      //      .pushReplacement(MaterialPageRoute(builder: (context) => login()));
      //     Fluttertoast.showToast(msg:"New User",gravity:ToastGravity.BOTTOM);
    }));
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
    Firebase.initializeApp();
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

  Future<void> getState() async {
    bool paid = false,
        exist = false;
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Users');

    if (user == null) {
      number = 1;
      return;
    }
    await collectionReference.doc(user.uid).get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        number = 2;
        return;
      }
      else {
        exist = true;
      }
    });

    if (exist) {
      DocumentSnapshot documentSnapshot =
      await collectionReference.doc(user.uid).get();

      List<dynamic> data = documentSnapshot.get('members');

      Iterable l = data;
      membersi = List<MemberModel>.from(
          l.map((model) => MemberModel.fromJson(model)));

      for (int i = 0; i < membersi.length; i++) {
        if (membersi[i].subscribed == true) {
          paid = true;
          break;
        }
      }

      if (paid) {
        number = 4;
        return;
      }
      number = 3;
      return;
    }
  }
}
