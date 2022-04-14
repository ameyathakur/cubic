import 'dart:io';
import 'dart:ui';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Custom Models/MemberModel.dart';
import '../models/User.dart';
import 'RegisterScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<dynamic> subusers = [];
  List<MemberModel> membersi = [];
  Map<String, bool> names = {};
  int price = 0;
  // late User user;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference keyReference =
      FirebaseFirestore.instance.collection('Razorpay');
  String rzp_key = '';
  final _razorpay = Razorpay();
  String email = '', contact = '';

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add the following line to add API plugin to your app

    try {
      DocumentSnapshot documentSnapshot =
          await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
      DocumentSnapshot keySnapshot = await keyReference.doc('id').get();

      setState(() {
        List<dynamic> data = documentSnapshot.get('members');

        email = documentSnapshot.get('emaild_id');
        contact = documentSnapshot.get('contact_no');
        rzp_key = keySnapshot.get('key');

        Iterable l = data;
        membersi = List<MemberModel>.from(
            l.map((model) => MemberModel.fromJson(model)));

        for (int i = 0; i < membersi.length; i++) {
          names[membersi[i].name] = true;
        }

        for (var k in names.values) {
          if (k == true) {
            price += 99;
          }
        }
      });
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Row(children: [
          Container(
            width: 73.0,
            height: double.infinity,
            color: const Color(0xFFFFBD59),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      new ListView(
                        shrinkWrap: true,
                        children: names.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: names[key],
                            onChanged: (val) {
                              setState(() {
                                names[key] = val!;
                                if (val == false) {
                                  price -= 99;
                                } else {
                                  price += 99;
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      Button(
                          text: 'Pay ' + price.toString(),
                          onPress: () async {
                            try {
                              var options = {
                                'key': rzp_key,
                                'currency': 'INR',
                                'theme': {'color': '#FFBD59'},
                                'amount': price * 100,
                                //in the smallest currency sub-unit.
                                'name': 'Cubic',
                                'description': 'Subscription',
                                'timeout': 60,
                                // in seconds
                                'prefill': {'contact': contact, 'email': email}
                              };
                              _razorpay.open(options);
                            } catch (e) {
                              print('error ' + e.toString());
                            }
                          },
                          color: const Color(0XFF208FEE),
                          borderColor: const Color(0XFF208FEE),
                          textColor: Colors.white),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
                        child: Text(
                            'You are just 1 step away from your medical record digital diary. Sit back and relax!',
                            textAlign: TextAlign.justify),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                            'We will remember your prescriptions and other medical records from here. Thank you for choosing Cubic.',
                            textAlign: TextAlign.justify),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text('Here are few things to note'))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 20, 0),
                          child: Text(
                            '1.	The above amount includes your annual subscription',
                            textAlign: TextAlign.justify,
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 20, 0),
                              child: Text(
                                '2.	The amount is inclusive of all taxes',
                                textAlign: TextAlign.justify,
                              ))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 20, 0),
                          child: Text(
                            '3.	You are allowed to store only medical records. If we identify any non-medical records, the user will be blocked and no refund will be offered.',
                            textAlign: TextAlign.justify,
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 20, 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(text: '4.	Please reach out to '),
                              TextSpan(
                                  text: 'cubic-support@transeunt.in',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final Email email = Email(
                                        recipients: [
                                          'cubic-support@transeunt.in'
                                        ],
                                      );
                                      await FlutterEmailSender.send(email);
                                    }),
                              TextSpan(text: ' for any queries')
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
        ]));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: response.signature.toString());
    for (int i = 0; i < membersi.length; i++) {
      if (names[membersi[i].name] == true) {
        membersi[i].deleted = false;
      } else {
        membersi[i].deleted = true;
      }
    }

    users
        .doc('64hhzztX4pqgPkdHg51N')
        .update({'members': membersi.map((i) => i.toMap()).toList()});

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Payment Faild');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('pratisaad ' + response.toString());
  }
}
