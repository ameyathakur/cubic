import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/Custom%20Models/MemberModel.dart';
import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/UI/PaymentScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:cubic/Widgets/FamilyMember.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../amplifyconfiguration.dart';

import '../models/ModelProvider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController email = new TextEditingController(),
    contact = new TextEditingController();

String dob = "";

var widgets = <Widget>[];

List<String> genders = <String>[
  'Select Gender',
  'Male',
  'Female',
  'Prefer not to say'
];

String selectedGender = 'Select Gender';

TextStyle defaultStyle = TextStyle(color: Colors.black);
TextStyle linkStyle = TextStyle(color: const Color(0XFF0000FF));

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<FamilyMember> members = [];
  final _formKey = GlobalKey<FormState>();

  var namecontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var adharcontroller = TextEditingController();
  var relationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    MemberModel firstModel = new MemberModel(
        name: namecontroller.text.toString(),
        relation: "Self",
        adhar: adharcontroller.text.toString(),
        gender: selectedGender,
        dob: dobcontroller.text.toString());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // A flexible child that will grow to fit the viewport but
          // still be at least as big as necessary to fit its contents.
          Container(
            color: const Color(0xFFFFBD59), // Red
            width: 73.0,
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child:
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter contact number';
                                  }
                                  return null;
                                },
                                controller: contact,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                    hintText: 'Contact No.',
                                    border: InputBorder.none),
                              ),
                            )),
                        Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email id';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Email id is invalid';
                                  }
                                  return null;
                                },
                                controller: email,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                    hintText: 'Email id',
                                    border: InputBorder.none),
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: TextFormField(
                                    controller: namecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0),
                                        hintText: 'Name',
                                        border: InputBorder.none),
                                  ),
                                )),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                        validator: (value) {
                                          if (value == 'Select Item') {
                                            return 'Please select gender';
                                          }
                                        },
                                        hint: Text(
                                          'Select Item',
                                        ),
                                        items: genders
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedGender,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedGender = newValue!;
                                          });
                                        })),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Date of Birth',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter Date of Birth';
                                            }
                                            return null;
                                          },
                                          controller: dobcontroller,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.0),
                                              border: InputBorder.none),
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900, 1),
                                              lastDate: DateTime.now(),
                                            ).then((pickedDate) {
                                              setState(() {
                                                var date = DateTime.parse(
                                                    pickedDate.toString());
                                                var formattedDate =
                                                    "${date.day}-${date.month}-${date.year}";
                                                dobcontroller.text =
                                                    formattedDate;
                                                dob = formattedDate;
                                              });
                                            });
                                          },
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: TextField(
                                    controller: adharcontroller,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0),
                                        hintText: 'Aadhar No.',
                                        border: InputBorder.none),
                                  ),
                                ))
                          ],
                        ),
                        ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          itemCount: members.length,
                          itemBuilder: (_, i) => members[i],
                        ),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    onAddForm();
                                  },
                                  child: Text('Add Family Member',
                                      style: TextStyle(fontSize: 16.0))),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: RichText(
                              text: TextSpan(
                                style: defaultStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'By clicking, you accept our '),
                                  TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(
                                          color: const Color(0XFF0000FF)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                ],
                              ),
                            )),
                        Button(
                            text: 'Register',
                            onPress: () async {
                              // if (_formKey.currentState!.validate()) {
                                //   // If the form is valid, display a snackbar. In the real world,
                                //   // you'd often call a server or save the information in a database.
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(content: Text('Registering')));
                                //
                                //       // Add the following line to add API plugin to your app
                                //       if (!Amplify.isConfigured) {
                                //     Amplify.addPlugin(AmplifyAPI(
                                //         modelProvider: ModelProvider.instance));
                                //
                                //     await Amplify.configure(amplifyconfig);
                                //   }
                                //
                                //   try {

                                //     final request = ModelMutations.create(user);
                                //     final response = await Amplify.API
                                //         .mutate(request: request)
                                //         .response;
                                //
                                //     User? createdUser = response.data;
                                //     if (createdUser == null) {
                                //       print('errors: ' + response.errors.toString());
                                //       return;
                                //     }
                                //     print('Mutation result: ' + createdUser.id);
                                //   } on ApiException catch (e) {
                                //     print('Mutation failed: $e');
                                //   } on AmplifyAlreadyConfiguredException {
                                //     print(
                                //         "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
                                //   }

                                List data = <MemberModel>[];
                                data.add(firstModel);

                                for (int i = 0; i < members.length; i++) {
                                  data.add(members[i].memberModel);
                                }

                                print("amey $data");

                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('Users');

                                users
                                    .add({
                                  'id': contact.text,
                                  'emaild_id': email.text,
                                  'contact_no': contact.text,
                                  'members':
                                  data.map((i) => i.toMap()).toList(),
                                })
                                    .then((value) => print("User Added"))
                                    .catchError((error) =>
                                    print("Failed to add user: $error"));

                                // FirebaseFirestore.instance.collection('users').doc('OKuHZlpVrS84oVn0mLpx').collection('members').add(data.);

                                // for (int i = 0; i < data.length; i++) {
                                //   MemberModel member = data[i];
                                //   FirebaseFirestore.instance
                                //       .collection('users')
                                //       .doc('tETfb31NFNO3XhhRnPhc')
                                //       .collection('members')
                                //       .add({
                                //         'name': member.name,
                                //         'relation': member.relation,
                                //         'adhar': member.adhar,
                                //         'dob': member.dob,
                                //         'subscribed': member.subscribed,
                                //         'deleted': member.deleted,
                                //         'gender': member.gender
                                //       })
                                //       .then((value) => print(data[i]))
                                //       .catchError((error) =>
                                //           print("Failed to add user: $error"));
                                // }

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PaymentScreen()));
                              },
                              // }
                            // },
                            color: const Color(0XFF208FEE),
                            borderColor: const Color(0XFF208FEE),
                            textColor: Colors.white)
                      ],
                    ))),
          )
        ],
      ),
    );
  }

  // void addMemberFields() {
  //
  //     TextEditingController nameController = TextEditingController(),
  //         genderController = TextEditingController(),
  //         dobController = TextEditingController(),
  //         adharController = TextEditingController();
  //
  //
  //     setState(() {

  void onDelete(MemberModel memberModel) {
    setState(() {
      var find = members.firstWhere(
        (it) => it.memberModel == memberModel,
      );
      members.removeAt(members.indexOf(find));
    });
  }

  void onAddForm() {
    setState(() {
      var _member = MemberModel();
      members.add(FamilyMember(
          memberModel: _member, onDelete: () => onDelete(_member)));
    });
  }
}
