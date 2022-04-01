import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/UI/OTPverification.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:cubic/UI/OTPverification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Widgets/Header.dart';
import 'RegisterScreen.dart';

class login extends StatefulWidget {
//login({Key? key}) : super(key: key);
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  String phone_number="";

  bool isLoading = false;

//........................................Validating phone-field..........................//

// validateMobile(TextEditingController value) {
//   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//   RegExp regExp = RegExp(pattern);
//   if (value.text.isEmpty || value.text.length!=12) {
//       return  Fluttertoast.showToast(msg:"Enter phone number",gravity:ToastGravity.BOTTOM);
//       }
//   else if (!regExp.hasMatch(value.text)) {
//       return  Fluttertoast.showToast(msg:"Enter valid phone number",gravity:ToastGravity.BOTTOM);
//   }
//   else{return null;}
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
                    phone_number = phone.completeNumber.toString();
                  },
                ),
                // child: TextFormField(
                //   controller: phone_number,
                // ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Button(
              text: 'Generate OTP',
              onPress: () {
                // if(validateMobile(phone_number)==null){
                //phoneSignIn(phone_number.text);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => otpVerification()));};

                print("1234 " + phone_number.length.toString());
                if (phone_number.length == 13) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              otpVerification(phn: phone_number)));
                }
                else{
                  Fluttertoast.showToast(msg: 'Enter valid phone number', gravity:ToastGravity.BOTTOM);
                }
              },
              color: const Color(0xFF208FEE),
              borderColor: const Color(0xFF208FEE),
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Divider(
              height: 2,
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

          GestureDetector(
            onTap: () async {
              //var user=FirebaseAuth.instance.currentUser;
              FirebaseAuth auth = FirebaseAuth.instance;
              User? user;

              final GoogleSignIn googleSignIn = GoogleSignIn();

              final GoogleSignInAccount? googleSignInAccount =
              await googleSignIn.signIn();

              if (googleSignInAccount != null) {
                final GoogleSignInAuthentication
                googleSignInAuthentication =
                await googleSignInAccount.authentication;

                final AuthCredential credential =
                GoogleAuthProvider.credential(
                  accessToken: googleSignInAuthentication.accessToken,
                  idToken: googleSignInAuthentication.idToken,
                );

                try {
                  final UserCredential userCredential =
                  await auth.signInWithCredential(credential);

                  user = userCredential.user;
                  // print('times ' + user!.metadata.creationTime.toString());

                  if (userCredential.additionalUserInfo!.isNewUser ==
                      true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MainScreen()));
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code ==
                      'account-exists-with-different-credential') {
                    // handle the error here
                  } else if (e.code == 'invalid-credential') {
                    // handle the error here
                  }
                } catch (e) {
                  // handle the error here
                }
              }
            },
            child:  Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'Assets/rectangle.png',
                ),
                Image.asset(
                  'Assets/google_logo.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
          Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'Assets/logo_rectangular.png',
                      width: 100.0,
                    )),
              )),
        ],
      ),
    );
  }
}
