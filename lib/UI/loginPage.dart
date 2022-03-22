import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/UI/OTPverification.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Widgets/Header.dart';
import 'MainScreen.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController phone=TextEditingController();
  String password='abcd1234';
  String email='ignored@gmail.com';

  Future<void> registerOrlogin(TextEditingController phone) async {
    Map<String, String> userAttributes = { 'email': "ignored@ignored.com"};
    try {
      SignUpResult result = await Amplify.Auth.signUp(
          username: phone.text.toString(),
          password: "ThisIsIgnored!",);
          //options: CognitoSignUpOptions(userAttributes: userAttributes));
      print("isSignUpComplete: ${result.isSignUpComplete}");
    } on UsernameExistsException catch (_) {
      print("User already exists. Proceed to login");
    }

    SignInResult signInResult = await Amplify.Auth.signIn(username: phone.text.toString(), password: "ThisIsIgnored!");

    print("isSignedIn: ${signInResult.isSignedIn}");
    if (!signInResult.isSignedIn &&
        signInResult.nextStep?.signInStep == "CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE") {
      //GO to confirmation page
      //Fluttertoast.showToast(msg: "We have sent you sms confirmation");
      otpVerification();
    }
    }

     Google_signin()async {
      try {
        var res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
        if(res.isSignedIn){
          return true;
        }else{
          return false;
        }

      } on AmplifyException catch (e) {
    print(e.message);
}
    }

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
                print(phone.completeNumber);
              },
              controller: phone,
              // )
            ),
          )),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Button(
                        text: 'Generate OTP',
                        onPress: () {
                          registerOrlogin(phone);
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
                    Button(
                      color: Colors.lightBlue,
                      text: 'Google',
                      textColor: Colors.black,
                      borderColor: Colors.blue,
                      onPress:(){
                        if(!Google_signin()){
                            Navigator.push( 
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MainScreen()));                         
                        }
                      }
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
