import 'package:cubic/Widgets/Header.dart';
import 'package:flutter/material.dart';

import '../Widgets/otpHeader.dart';
import '../Widgets/verification.dart';

class otpVerification extends StatefulWidget {
  @override
  _otpVerificationState createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Header(
              title: 'Verify OTP',
              subtitle: 'A 6 digit OTP has been sent to your number'),
          verification(),
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
