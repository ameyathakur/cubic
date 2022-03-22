import 'package:cubic/UI/AddDocument.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:cubic/Widgets/DetailsRow.dart';
import 'package:cubic/Widgets/VerticalBar.dart';
import 'package:flutter/material.dart';

import 'OTPverification.dart';

//Variables of details
String name = 'Name of the User',
    disease = 'Illness',
    docName = 'Name of the Doctor',
    date = 'Date of Visit',
    comments = 'Comments by the user';

List<String> tags = <String>[
  "tag1",
  "tag2",
  "tag3",
  "tag4",
  "tag5",
];

class documentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Row(children: [
        VerticalBar(),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF000000), width: 1),
                          image: DecorationImage(
                            image: AssetImage('Assets/sample.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          width: 200,
                          height: 35,
                          child: Container(
                              width: double.infinity,
                              color: const Color(0xFFD31C1C),
                              child: GestureDetector(
                                child: Center(
                                    child: Text(
                                  'View PDF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto'),
                                )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              otpVerification()));
                                },
                              ))),
                    ],
                  )),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10, bottom: 10),
                  color: const Color(0xFFF1EBEB),
                  child: Row(children: [
                    Text(
                      'Details:',
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Button(
                              text: 'Edit',
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AddDocument()));
                              },
                              color: Color(0xFFCFC9C9),
                              borderColor: Colors.black,
                              textColor: Colors.black)),
                    ),
                  ])),
              DetailsRow(title: "Patient's Name:", subtitle: name),
              DetailsRow(title: "Illness:", subtitle: disease),
              DetailsRow(title: "Doctor's Name:", subtitle: docName),
              DetailsRow(title: "Date", subtitle: date),
              DetailsRow(title: "Comments:", subtitle: comments),
              Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: tags
                        .map(
                          (element) => Chip(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.5)),
                                side: BorderSide()),
                            label: Text(element),
                            backgroundColor: const Color(0xFFFFFFF),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'Assets/logo_rectangular.png',
                      width: 100.0,
                    )),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
