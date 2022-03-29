import 'package:cubic/UI/UserProfile.dart';
import 'package:cubic/UI/documentDetails.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/material.dart';

import 'AddDocument.dart';

List<String> names = <String>[
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever",
  "26-02-21_Dr_Kishore_Fever"
];
List<String> images = <String>[
  'Assets/prescription.png',
  'Assets/lab_report.png',
  'Assets/medical_certificate.png',
  'Assets/prescription.png',
  'Assets/lab_report.png',
  'Assets/medical_certificate.png',
  'Assets/prescription.png',
  'Assets/lab_report.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png',
  'Assets/prescription.png',
  'Assets/lab_report.png',
  'Assets/medical_certificate.png',
  'Assets/prescription.png',
  'Assets/lab_report.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png',
  'Assets/medical_certificate.png'
];

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFFFFBD59),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Padding(
                padding: EdgeInsets.only(top: 10, right: 20),
                child: Button(
                    text: 'Add Document',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddDocument()));
                    },
                    color: const Color(0xFFFFBD59),
                    borderColor: Colors.black,
                    textColor: Colors.black)),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserProfile()));

                  // Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(top: 50, bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBD59),
                ),
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextField(
                        showCursor: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10.0),
                            hintText:
                                'Search by Prescription, Doctor’s name or Disease',
                            border: InputBorder.none),
                      ),
                    ))),
            Padding(
                padding: EdgeInsets.only(left: 40, top: 40, bottom: 20),
                child: Text('Recents', style: const TextStyle(fontSize: 20.0))),
            ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: names.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    documentDetails()));
                      },
                      child: Row(children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          height: 50.0,
                          width: 50.0,
                          child: Image.asset(images[index]),
                        ),
                        Flexible(child: Text(names[index]))
                      ]));
                })
          ]),
        ));
  }
}
