import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/Custom%20Models/MemberModel.dart';
import 'package:cubic/UI/RegisterScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String email = '', contact = '';
  List<dynamic> subusers = [];
  List<MemberModel> membersi = [];
  late User user;
  TextEditingController dobcontroller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xFFFFBD59),
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: Button(
                    text: 'Edit',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen()));
                    },
                    color: const Color(0xFFFFBD59),
                    borderColor: Colors.black,
                    textColor: Colors.black))
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc('ejm41xk4kdo2srkZOpjm').get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                email = data['emaild_id'];

                contact = data['contact_no'];

                List<dynamic> members = data['members'];

                Iterable l = members;
                membersi = List<MemberModel>.from(
                    l.map((model) => MemberModel.fromJson(model)));

                print('Pune ' + members.toString());
              }

              return Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'Email id',
                            style: TextStyle(
                                color: const Color(0xFF827E7E), fontSize: 18),
                          ),
                        ),
                        Container(
                            width: 40,
                            child: Text(
                              ':',
                              style: TextStyle(fontSize: 18),
                            )),
                        Text(
                          email,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              'Contact No.',
                              style: TextStyle(
                                  color: const Color(0xFF827E7E), fontSize: 18),
                            ),
                          ),
                          Container(
                              width: 40,
                              child: Text(
                                ':',
                                style: TextStyle(fontSize: 18),
                              )),
                          Text(
                            contact,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.all(10),
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: membersi.length,
                        itemBuilder: (BuildContext context, int index) {
                         {
                            dobcontroller = new TextEditingController(
                                text: membersi[index].dob);
                          }

                          return Column(children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Member ' + (index + 1).toString())),
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            title: Text(
                                                              'Update the details of ' +
                                                                  membersi[
                                                                          index]
                                                                      .name,
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        top:
                                                                            20),
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .black,
                                                                            width:
                                                                                1.5),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                7)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          TextFormField(
                                                                        initialValue:
                                                                            membersi[index].name,
                                                                        // controller: namecontroller,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return 'Please enter your name';
                                                                          }
                                                                          return null;
                                                                        },
                                                                        onChanged:
                                                                            (val) {
                                                                          membersi[index].name =
                                                                              val;
                                                                        },
                                                                        decoration: InputDecoration(
                                                                            contentPadding:
                                                                                EdgeInsets.only(left: 10.0),
                                                                            hintText: 'Name',
                                                                            border: InputBorder.none),
                                                                      ),
                                                                    )),
                                                                (index == 0)
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20,
                                                                            top:
                                                                                20),
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            border: Border.all(
                                                                                color: Colors
                                                                                    .black,
                                                                                width:
                                                                                    1.5),
                                                                            borderRadius: BorderRadius.circular(
                                                                                7)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextFormField(
                                                                            // controller: adharcontroller,
                                                                            initialValue:
                                                                                membersi[index].adhar,
                                                                            decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.only(left: 10.0),
                                                                                hintText: 'Aadhar No.',
                                                                                border: InputBorder.none),
                                                                            onChanged:
                                                                                (val) {
                                                                              membersi[index].adhar = val;
                                                                            },
                                                                          ),
                                                                        ))
                                                                    : Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20,
                                                                            top:
                                                                                20),
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border: Border.all(color: Colors.black, width: 1.5),
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child: Center(
                                                                          child:
                                                                              TextFormField(
                                                                            // onChanged: (val) => widget.memberModel.relation = val!,
                                                                            decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.only(left: 10.0),
                                                                                hintText: 'Relation',
                                                                                border: InputBorder.none),
                                                                            initialValue:
                                                                                membersi[index].relation,
                                                                            onChanged:
                                                                                (val) {
                                                                              membersi[index].relation = val;
                                                                            },
                                                                          ),
                                                                        )),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              20),
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              1.5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
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
                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                      value: item,
                                                                                      child: Text(
                                                                                        item,
                                                                                        style: const TextStyle(
                                                                                          fontSize: 14,
                                                                                        ),
                                                                                      ),
                                                                                    ))
                                                                                .toList(),
                                                                            value: membersi[index].gender,
                                                                            onChanged: (String? newValue) {
                                                                              selectedGender = newValue!;
                                                                              membersi[index].gender = newValue!;
                                                                            })),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        'Date of Birth',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18.0),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                                                          width: double.infinity,
                                                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1.5), borderRadius: BorderRadius.circular(7)),
                                                                          child: Center(
                                                                            child:
                                                                                TextFormField(
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Enter Date of Birth';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              controller: dobcontroller,
                                                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10.0), border: InputBorder.none),
                                                                              onTap: () {
                                                                                showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  firstDate: DateTime(1900, 1),
                                                                                  lastDate: DateTime.now(),
                                                                                ).then((pickedDate) {
                                                                                  var date = DateTime.parse(pickedDate.toString());
                                                                                  var formattedDate = "${date.day}-${date.month}-${date.year}";

                                                                                  dobcontroller.text = formattedDate;

                                                                                  dob = formattedDate;

                                                                                  membersi[index].dob = dob;
                                                                                });
                                                                              },
                                                                            ),
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 20),
                                                                  child: Button(
                                                                      text:
                                                                          'Update',
                                                                      onPress:
                                                                          () async {
                                                                        print('iuy ' +
                                                                            membersi[index].dob);

                                                                        users
                                                                            .doc(
                                                                                'ejm41xk4kdo2srkZOpjm')
                                                                            .update({
                                                                          'members': membersi
                                                                              .map((i) => i.toMap())
                                                                              .toList()
                                                                        });

                                                                        Navigator.of(context,
                                                                                rootNavigator: true)
                                                                            .pop();


                                                                      },
                                                                      color: new Color(
                                                                          0xFF208FEE),
                                                                      borderColor:
                                                                          new Color(
                                                                              0xFF208FEE),
                                                                      textColor:
                                                                          Colors
                                                                              .white),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () async {
                                              membersi.removeAt(index);

                                              users
                                                  .doc('ejm41xk4kdo2srkZOpjm')
                                                  .update({
                                                'members': membersi
                                                    .map((i) => i.toMap())
                                                    .toList()
                                              });
                                            },
                                            icon: Icon(Icons.delete)),
                                      ]),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    membersi[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Text(
                                          membersi[index].gender[0],
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  ))
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  membersi[index].adhar != ''
                                      ? Text(membersi[index].adhar)
                                      : Text(membersi[index].relation),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Text(
                                          membersi[index].dob,
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  ))
                                ],
                              ),
                            ),
                          ]);
                        })
                  ],
                ),
              );
            }));
  }
}
