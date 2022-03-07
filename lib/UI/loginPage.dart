import 'package:cubic/UI/OTPverification.dart';
import 'package:cubic/Widgets/Button.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Widgets/Header.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Header(title: 'Login', subtitle: "Welcome to Cubic"),
          Material(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xFF208FEE), width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              // )
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Button(
              text: 'Generate OTP',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => otpVerification()));
              },
              color: const Color(0xFF208FEE),
              borderColor: const Color(0xFF208FEE),
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Divider(
              color: const Color(0xFFBEB9B9),
            ),
          ),
          Text(
            'OR',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              'Sign in using',
              style: TextStyle(
                  fontFamily: 'Roboto', color: const Color(0xFF888585)),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'Assets/rectangle.png',
              ),
              Image.asset(
                'Assets/google_logo.png',
                width: 50,
                height: 50,
              )
            ],
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'Assets/logo_rectangular.png',
                  width: 150.0,
                )),
          )),
        ],
      ),
    );
  }
}
