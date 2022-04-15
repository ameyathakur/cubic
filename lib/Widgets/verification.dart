import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Custom Models/MemberModel.dart';
import '../UI/MainScreen.dart';
import '../UI/PaymentScreen.dart';
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

  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('Users');

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
        print('arrived in completed');
        timer.cancel();
        List<String> pin = [];

        for (int i = 0; i < credential.smsCode!.length; i++) {
          pin.add((credential.smsCode).toString()[i]);
        }

        setState(() {
          otpFieldController.set(pin);
        });

        if(FirebaseAuth.instance.currentUser == null) {
          signInAndNavigate(credential);
        }
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
        if (FirebaseAuth.instance.currentUser == null) {
          Fluttertoast.showToast(
              msg: 'Time out. Try again',
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        }
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fieldWidth: 50,
              style: TextStyle(fontSize: 15),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) async {
                otpCode = pin;

                if (FirebaseAuth.instance.currentUser == null) {
                  print('sha ' + '1');
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificat, smsCode: otpCode);
                  timer.cancel();

                  signInAndNavigate(credential);
                }
                else {
                  print('sha ' + '2');
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

                      if (FirebaseAuth.instance.currentUser == null) {
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificat, smsCode: otpCode);
                        timer.cancel();

                        signInAndNavigate(credential);
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

  signInAndNavigate(AuthCredential credential) async {
    try{
      String uid;
      await _auth.signInWithCredential(credential)
          .then((value) async => {
        Fluttertoast.showToast(
            msg: "Mobile number verified successfully",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG),
        uid = value.user!.uid,
        await collectionReference
            .doc(uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          bool paid = false;
          if (!documentSnapshot.exists) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RegisterScreen()));
          } else {
            List<dynamic> data =
            documentSnapshot.get('members');

            List<MemberModel> membersi = [];
            Iterable l = data;
            membersi = List<MemberModel>.from(
                l.map((model) => MemberModel.fromJson(model)));

            for (int i = 0; i < membersi.length; i++) {

              if (membersi[i].deleted == false) {
                paid = true;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MainScreen()));
                return;
              }
            }

            if (paid == false) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PaymentScreen()));
            }
          }
        }
        ),
      });}catch (error) {
      print('Sanjita ' + error.toString());
    }
  }

}