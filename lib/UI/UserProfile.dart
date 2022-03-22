import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/Custom%20Models/MemberModel.dart';
import 'package:cubic/UI/RegisterScreen.dart';
import 'package:cubic/Widgets/Button.dart';
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

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add the following line to add API plugin to your app

    try {
      final getUser = await ModelQueries.get(User.classType, '8766896763');
      final userResponse = await Amplify.API.query(request: getUser).response;
      User? user = userResponse.data;
      if (user == null) {
        print('errors: ' + userResponse.errors.toString());
      }

      setState(() {
        email = user!.emaild_id;
        contact = user.contact_no;

        String? membes = user.members;

        subusers = jsonDecode(membes!);

        Iterable l = json.decode(membes);
        membersi = List<MemberModel>.from(
            l.map((model) => MemberModel.fromJson(model)));


      });
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  @override
  build(BuildContext context) {
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
        body: Padding(
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
                  itemBuilder: (BuildContext context, int index)
                  {
                    return
                      Column(children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Member ' + (index + 1).toString())),
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () async {

                                        membersi.removeAt(index);
                                        var json = jsonEncode(
                                            membersi.map((e) => e.toJson()).toList());

                                        User user = User(
                                            id: '8766896763',
                                            emaild_id: email,
                                            contact_no: contact,
                                            members: json);

                                        final request = ModelMutations.update(user);
                                        final response = await Amplify.API.mutate(request: request).response;

                  _configureAmplify();
                                      }, icon: Icon(Icons.delete)),
                                ))
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
        ));
  }
}
