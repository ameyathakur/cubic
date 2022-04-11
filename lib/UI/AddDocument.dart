import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/Custom%20Models/Document.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';

String chip1 = 'Tag 1', chip2 = 'Tag 2', chip3 = 'Tag 3';

enum members { Prescription, Test_Report, Certificate }
members m = members.Prescription;

class AddDocument extends StatefulWidget {
  const AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  List<File> imageList = [];
  int? _value = 0;
  List<String> chips = ['Fever', 'Routine', 'BP'];
  TextEditingController nameController = TextEditingController();
  TextEditingController illnessController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  List<String> categories = ['Prescription', 'Test Report', 'Certificate'];

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 73.0,
            color: const Color(0xFFFFBD59),
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10.0),
                                hintText: 'Name',
                                border: InputBorder.none),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: TextField(
                            controller: illnessController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10.0),
                                hintText: 'Illness',
                                border: InputBorder.none),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: TextField(
                            controller: doctorController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10.0),
                                hintText: "Doctor's Name",
                                border: InputBorder.none),
                          ),
                        )),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Date of Visit',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Flexible(
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: TextField(
                                    controller: dobController,
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
                                          dobController.text = formattedDate;
                                        });
                                      });
                                    }),
                              )),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: TextField(
                            controller: commentsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Comments',
                                border: InputBorder.none),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                          child: Text(
                            'Add Tags',
                            style: TextStyle(fontSize: 18),
                          ),
                        )),
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        padding: EdgeInsets.only(left: 20),
                        primary: true,
                        shrinkWrap: true,
                        children: <Widget>[
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 0.0,
                            children: List<Widget>.generate(
                                chips
                                    .length, // place the length of the array here
                                (int index) {
                              return Chip(
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  setState(() {
                                    chips.removeAt(index);
                                  });
                                },
                                label: Text(chips[index]),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Add Tag'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 20),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Center(
                                                    child: TextField(
                                                      controller: tagController,
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 10.0),
                                                          hintText:
                                                              'Name of the tag',
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: Button(
                                                      text: 'Add Tag',
                                                      onPress: () {
                                                        setState(() {
                                                          chips.add(tagController.text);
                                                        });
                                                        Navigator.of(context,
                                                            rootNavigator: true)
                                                            .pop();
                                                      },
                                                      color: const Color(
                                                          0XFF208FEE),
                                                      borderColor: const Color(
                                                          0XFF208FEE),
                                                      textColor: Colors.white))
                                            ],
                                          ),
                                        ));
                              },
                              child: Text('+'),
                            ))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                          child: Text(
                            'Select Category',
                            style: TextStyle(fontSize: 18),
                          ),
                        )),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.only(left:20),child:
                Wrap(
                    spacing: 4.0,
                children: List.generate(
                  categories.length,
                      (int index) {
                    return ChoiceChip(
                      label: Text(categories[index]),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;
                        });
                      },
                    );
                  },
                ).toList())),),

                    (imageList.length != 0)
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child: SizedBox(
                              height: 100.0,
                              child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imageList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: 100,
                                                child: (imageList[index].path.split('.').last != "pdf")?
                                                Image.file(
                                                    imageList[index]): Padding(padding: EdgeInsets.only(left: 25, top: 4), child: Text(basename(imageList[index].path))),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                icon: Icon(Icons.close,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    imageList.removeAt(index);
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ));
                                  }),
                            ))
                        : SizedBox(),

                    //

                    OutlinedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: Text('Add Image from'),
                                content: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Button(
                                        text: 'Import',
                                        onPress: () async {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                                          if (result != null) {
                                            File image = File(result.files.single.path.toString());

                                            if (image != null) {
                                              setState(() {
                                                imageList.add(image);
                                              });
                                            }
                                            print("Image List Length:" +
                                                imageList!.length.toString());
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        borderColor: new Color(0xFF208FEE),
                                        textColor: Colors.white,
                                        color: new Color(0xFF208FEE),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Button(
                                        text: 'Scan',
                                        onPress: () async {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          FlutterGeniusScan
                                              .scanWithConfiguration({
                                            'source': 'camera',
                                            'multiPage': true,
                                          }).then(
                                            (result) {
                                              for (int i = 0;
                                                  i < result.length;
                                                  i++) {
                                                String imageUrl =
                                                    result['scans'][i]
                                                        ['enhancedUrl'];
                                                File file = new File(imageUrl
                                                    .replaceAll('file://', ''));
                                                setState(() {
                                                  imageList.add(file);
                                                });
                                              }
                                              print('iuy ' +
                                                  imageList.toString());
                                            },
                                          );
                                        },
                                        borderColor: new Color(0xFF208FEE),
                                        textColor: Colors.white,
                                        color: new Color(0xFF208FEE),
                                      ),
                                    )
                                  ],
                                )));
                      },
                      child: Text('+ Add Document'),
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                            '* Size of Document should be less than 500 KB')),

                    Button(
                        text: 'Save',
                        onPress: () async {
                          String category='';
                          switch(_value){
                            case 0:
                              {
                                category = 'Prescription';
                              }
                              break;

                            case 1:
                              {
                                category = 'Test Report';
                              }
                              break;
                            case 2:
                              {
                                category = 'Certificate';
                              }
                              break;

                          }

                          DateTime currentPhoneDate = DateTime.now();
                          Timestamp time = Timestamp.fromDate(currentPhoneDate);

                          String uid = await FirebaseAuth.instance.currentUser!.uid;
                          List<String> imageUrls = [];
                          int i = 0;
                          for (File imageFile in imageList) {
                            try {
                              TaskSnapshot taskSnapshot = await FirebaseStorage.instance.ref(uid + time.toString()).child(i.toString()).putFile(imageFile);
                              String imageUrl = await taskSnapshot.ref.getDownloadURL();
                              imageUrls.add(imageUrl);
                              i++;
                            } catch (err) {
                              print(err);
                            }
                          }

                          Document document = new Document(nameController.text, illnessController.text, doctorController.text, dobController.text, commentsController.text, category, imageUrls, chips, uid + time.toString());

                          CollectionReference reference = FirebaseFirestore.instance.collection('Users');

                          reference.doc(uid).collection('Documents').doc(uid + time.toString()).set(document.toMap());
                          
                        },
                        color: const Color(0XFF208FEE),
                        borderColor: const Color(0XFF208FEE),
                        textColor: Colors.white)
                  ],
                )),
          )
        ],
      ),
    );
  }
}

// String pdfUrl = result['pdfUrl'];
// OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
//         (result) => debugPrint(result.toString()));
