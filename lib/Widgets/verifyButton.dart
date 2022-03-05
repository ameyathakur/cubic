import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/UI/RegisterScreen.dart';
import 'package:flutter/material.dart';

class verifyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 200,
        height: 50,
        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Text(
            "Verify",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ]));
  }
}
