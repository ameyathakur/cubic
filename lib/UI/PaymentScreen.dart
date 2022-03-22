import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/material.dart';

enum members { member1, member2, member3 }
members m = members.member1;
int price = 500;

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      ListTile(
                        title: const Text('Member 1'),
                        leading: Radio<members>(
                          value: members.member1,
                          groupValue: m,
                          onChanged: (members? value) {},
                        ),
                      ),
                      ListTile(
                        title: const Text('Member 2'),
                        leading: Radio<members>(
                          value: members.member2,
                          groupValue: m,
                          onChanged: (members? value) {},
                        ),
                      ),
                      ListTile(
                        title: const Text('Member 3'),
                        leading: Radio<members>(
                          value: members.member3,
                          groupValue: m,
                          onChanged: (members? value) {},
                        ),
                      ),
                      Button(
                          text: 'Pay 500',
                          onPress: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen()));
                          },
                          color: const Color(0XFF208FEE),
                          borderColor: const Color(0XFF208FEE),
                          textColor: Colors.white),
                    ],
                  ))),
        ]));
  }
}
