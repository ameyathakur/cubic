import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/UI/UserProfile.dart';
import 'package:cubic/UI/documentDetails.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Custom Models/Document.dart';
import 'AddDocument.dart';
import 'loginPage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  List<DocumentSnapshot> documents = [];
  List<Document> documentsModel = [];

  Future<void> signout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await FirebaseAuth.instance.signOut();
      googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }

  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                      Navigator.pushReplacement(
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
                child: Text('Cubic'),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UserProfile()));
                },
              ),
              ListTile(
                title: const Text('Sign out'),
                onTap: () async {
                  // Update the state of the app
                  signout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => login()));
                  // Then close the drawer
                  //Navigator.pop(context);
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
                        onChanged: (val) {
                          setState(() {
                            searchText = val;
                          });
                          search();
                        },
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

            FutureBuilder(
                future: search(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return new ListView(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      children: documents.map((doc) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          documentDetails(
                                              documentSnapshot: doc)));
                            },
                            child: Row(children: [
                              Padding(padding: EdgeInsets.all(10.0)),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 50.0,
                                  width: 50.0,
                                  child: ((doc.data() as Map<String,
                                      dynamic>)['category'] == 'Prescription')
                                      ? Image.asset('Assets/prescription.png')
                                      : ((doc.data() as Map<String,
                                      dynamic>)['category'] == 'Test Report')
                                      ? Image.asset('Assets/lab_report.png')
                                      : Image.asset(
                                      'Assets/medical_certificate.png')
                              ),
                              Flexible(child: Text((doc.data() as Map<String,
                                  dynamic>)['date of visit'] + '_' +
                                  (doc.data() as Map<String,
                                      dynamic>)['doctor'] + '_' +
                                  (doc.data() as Map<String,
                                      dynamic>)['illness'])),
                            ]));
                      }).toList());
                })
          ]),
        )
    );
  }

  Future<List<DocumentSnapshot>> search() async {
    CollectionReference documentReference =
    await db.collection('Users').doc(uid).collection('Documents');

    List<DocumentSnapshot> dummy = [];
    {
      await documentReference.get().then((value) async {
        for (DocumentSnapshot element in value.docs) {
          bool flag = true;

          if (element.get('category').toString().toLowerCase().contains(
              searchText.toLowerCase())) {
            print('catrgory');
            dummy.add(element);
            flag = false;
          }
          if (flag && element.get('comments').toLowerCase().toString().contains(
              searchText.toLowerCase())) {
            print('comments');
            dummy.add(element);
            flag = false;
          }
          if (flag &&
              element.get('date of visit').toLowerCase().toString().contains(
                  searchText.toLowerCase())) {
            print('dob');
            dummy.add(element);
            flag = false;
          }

          if (flag && element.get('doctor').toString().toLowerCase().contains(
              searchText.toLowerCase())) {
            print('doctor');
            dummy.add(element);
            flag = false;
          }

          if (flag && element.get('illness').toString().toLowerCase().contains(
              searchText.toLowerCase())) {
            print('illness');
            dummy.add(element);
            flag = false;
          }

          if (flag && element.get('name').toString().toLowerCase().contains(
              searchText.toLowerCase())) {
            print('name');
            dummy.add(element);
            flag = false;
          }

          if (flag && element.get('tags').toString().toLowerCase().contains(
              searchText.toLowerCase())) {
            print('tags');
            dummy.add(element);
            flag = false;
          }

          if (flag) {
            await documentReference.doc(element.id).collection('ocr').get()
                .then((value) {
              bool semiflag = true;
              for (DocumentSnapshot oc in value.docs) {
                if (semiflag && oc['text'].toString().toLowerCase().contains(
                    searchText.toLowerCase())) {
                  dummy.add(element);
                  semiflag = false;
                }
              }
            });
          }
        }
      });
    }
    print('2');
    documents = dummy;
    return documents;
  }
}