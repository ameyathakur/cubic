import 'package:flutter/material.dart';
class otpHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text("Verify OTP",style: TextStyle(color: Colors.black,fontSize: 40),),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("6-digit code send to +91 *******678, enter the code",style: TextStyle(color: Colors.black,fontSize: 20),),
          )
        ],
      ),
      );
  }
}