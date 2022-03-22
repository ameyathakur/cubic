import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {

  TextEditingController name = new TextEditingController(),
    gender = new TextEditingController(),
    email = new TextEditingController(),
    contact = new TextEditingController(),
    showingdob = new TextEditingController(),
    adhar = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Container(
          decoration: BoxDecoration(color: const Color(0xFFFFBD59),),
        ),
          Padding(
            padding: EdgeInsets.all(10),
            child:
              Column(
              children: [
                Text('Name:',style:TextStyle(color: Colors.black)),
                Text('Gender:',style:TextStyle(color: Colors.black)),
                Text('email:',style:TextStyle(color: Colors.black)),
                Text('Contact',style:TextStyle(color: Colors.black)),
                Text('DOB:',style:TextStyle(color: Colors.black)),
                Text('Aadhar Number:',style:TextStyle(color: Colors.black)),
              ],
            ),
        )
      ],)
    );
  }
}