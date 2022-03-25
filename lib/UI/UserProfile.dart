import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/Custom%20Models/MemberModel.dart';
import 'package:cubic/UI/AddDocument.dart';
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
  List<TextEditingController> dobcontrollers = [];
  final db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> members = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  void initState() {
    super.initState();
  }

  // void _configureAmplify() async {
  //   // Add the following line to add API plugin to your app
  //
  //   try {
  //     final getUser = await ModelQueries.get(User.classType, '8766896763');
  //     final userResponse = await Amplify.API.query(request: getUser).response;
  //     user = userResponse.data!;
  //     if (user == null) {
  //       print('errors: ' + userResponse.errors.toString());
  //     }
  //
  //     setState(() {
  //       email = user!.emaild_id;
  //       contact = user.contact_no;
  //
  //       String? membes = user.members;
  //
  //       subusers = jsonDecode(membes!);
  //
  //       Iterable l = json.decode(membes);
  //       membersi = List<MemberModel>.from(
  //           l.map((model) => MemberModel.fromJson(model)));
  //
  //       for (int i = 0; i < membersi.length; i++) {
  //         TextEditingController dobcontroller =
  //             TextEditingController(text: membersi[i].dob);
  //         dobcontrollers.add(dobcontroller);
  //       }
  //     });
  //   } on ApiException catch (e) {
  //     print('Query failed: $e');
  //   }
  // }

  @override
  build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: members,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        print("stash " + snapshot.data!.docs.toString());
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            print(data.toString());
            return Material(child:
              ListTile(
              title: Text(data.toString()),
              subtitle: Text(data.toString()),
            ));
          }).toList(),
        );
      },
    );
  }
}
