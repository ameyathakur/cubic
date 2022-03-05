import 'package:cubic/Widgets/Button.dart';
import 'package:cubic/Widgets/verifyButton.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../UI/RegisterScreen.dart';

class verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textFiledOTP(first: true, last: false),
                    _textFiledOTP(first: false, last: false),
                    _textFiledOTP(first: false, last: false),
                    _textFiledOTP(first: false, last: false),
                    _textFiledOTP(first: false, last: false),
                    _textFiledOTP(first: false, last: true)
                  ],
                )
              ]),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Button(
                    text: "Verify OTP",
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    color: const Color(0xFF208FEE),
                    borderColor: const Color(0xFF208FEE),
                    textColor: const Color(0xFFFFFFFF))),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextButton(
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ),
            Text(
              'Valid till',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            MyWidget()
          ],
        ),
      ),
    );
  }
}

_textFiledOTP({bool? first, last}) {
  return Container(
    height: 70,
    child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            // if(value.length==1 && last==false){
            //   FocusScope.of(context).nextFocus();
            // }
            // if(value.length==1 && first==false){
            //   FocusScope.of(context).previousFocus();
            // }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10))),
        )),
  );
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 20,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(seconds: 1),
      onFinished: () {
        // print('Timer is done!');
      },
    );
  }
}
