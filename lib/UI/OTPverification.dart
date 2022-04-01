import 'package:cubic/Widgets/Header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/otpHeader.dart';
import '../Widgets/verification.dart';

class otpVerification extends StatefulWidget {

  final String? phn;
  otpVerification({Key? key, @required this.phn}) : super(key: key);

  @override
  _otpVerificationState createState() => _otpVerificationState();
}
class _otpVerificationState extends State<otpVerification> {

  check(){print("Phone number on OTP verification page " + widget.phn.toString());}

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Header(
              title: 'Verify OTP',
              subtitle: 'A 6 digit OTP has been sent to ' + widget.phn.toString()),

          verification(phone_Number: widget.phn.toString(),),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'Assets/logo_rectangular.png',
                    width: 100.0,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
