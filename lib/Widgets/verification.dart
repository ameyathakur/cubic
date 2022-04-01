import 'dart:async';

import 'package:cubic/Widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../UI/MainScreen.dart';
import '../UI/RegisterScreen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class verification extends StatefulWidget {
  final String? phone_Number;

  verification({Key? key, @required this.phone_Number}) : super(key: key);

  @override
  _verificationState createState() => _verificationState();
}

class _verificationState extends State<verification> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    phoneSignIn(phoneNumber: widget.phone_Number.toString());
  }

  late Timer timer;
  bool clicked = false;
  int seconds = 60;
  OtpFieldController otpFieldController = new OtpFieldController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String otpCode = '';
  String verificat = '';

  Future<void> phoneSignIn({required String phoneNumber}) async {
    seconds = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        timer.cancel();
        List<String> pin = [];

        for (int i = 0; i < credential.smsCode!.length; i++) {
          pin.add((credential.smsCode).toString()[i]);
        }

        setState(() {
          otpFieldController.set(pin);
        });
        await _auth.signInWithCredential(credential).then((value) async => {
              Fluttertoast.showToast(
                  msg: "Mobile number verified successfully",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG),
              if (value.additionalUserInfo?.isNewUser == false)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen())),
                }
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RegisterScreen())),
                }
            });
      },
      verificationFailed: (FirebaseAuthException e) {
        timer.cancel();
        Fluttertoast.showToast(
            msg: e.message.toString(),
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      },
      codeSent: (String verificationI, int? resendToken) async {
        verificat = verificationI;
        Fluttertoast.showToast(
            msg: 'Code sent successfully',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Fluttertoast.showToast(
            msg: 'Time out. Try again',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            OTPTextField(
              length: 6,
              controller: otpFieldController,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: TextStyle(fontSize: 15),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) async {
                otpCode = pin;

                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificat, smsCode: otpCode);

                try {
                  {
                    // Sign the user in (or link) with the credential
                    await _auth
                        .signInWithCredential(credential)
                        .then((value) => {
                              timer.cancel(),
                              print('1209'),
                              if (value.additionalUserInfo?.isNewUser == false)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MainScreen())),
                                }
                              else
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterScreen())),
                                }
                            });
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-verification-code') {
                    Fluttertoast.showToast(msg: 'You have entered wrong OTP');
                  }
                }
              },
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Button(
                    text: "Verify OTP",
                    onPress: () async {
                      timer.cancel();
                      print('765');
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: verificat, smsCode: otpCode);

                      try {
                        {
                          // Sign the user in (or link) with the credential
                          await _auth
                              .signInWithCredential(credential)
                              .then((value) => {
                                    timer.cancel(),
                                    print('1209'),
                                    if (value.additionalUserInfo?.isNewUser ==
                                        false)
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainScreen())),
                                      }
                                    else
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        RegisterScreen())),
                                      }
                                  });
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-verification-code') {
                          Fluttertoast.showToast(
                              msg: 'You have entered wrong OTP');
                        }
                      }
                    },
                    color: const Color(0xFF208FEE),
                    borderColor: const Color(0xFF208FEE),
                    textColor: const Color(0xFFFFFFFF))),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Valid till',
                  style: TextStyle(fontFamily: 'Roboto'),
                )),
            Text('$seconds'),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextButton(
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  timer.cancel();
                  setState(() {
                    otpFieldController.clear();
                  });

                  phoneSignIn(phoneNumber: widget.phone_Number.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _textFiledOTP({bool? first, last}) {
//   return Container(
//     height: 70,
//     child: AspectRatio(
//         aspectRatio: 0.6,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             // if(value.length==1 && last==false){
//             //   FocusScope.of(context).nextFocus();
//             // }
//             // if(value.length==1 && first==false){
//             //   FocusScope.of(context).previousFocus();
//             // }
//           },
//           showCursor: true,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//               counter: Offstage(),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.black)),
//               focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     width: 2,
//                     color: Colors.black,
//                   ),
//                   borderRadius: BorderRadius.circular(10))),
//         )),
//   );
// }
