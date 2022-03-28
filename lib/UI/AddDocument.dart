import 'dart:io';

import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  @override
  Widget build(BuildContext context) {
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
                            showCursor: false,
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
                            showCursor: false,
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
                            showCursor: false,
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
                                  showCursor: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 10.0),
                                      border: InputBorder.none),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2019, 1),
                                      lastDate: DateTime(20212, 12),
                                    ).then((pickedDate) {
                                      //do whatever you want
                                    });
                                  },
                                ),
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
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            showCursor: false,
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Chip(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.5)),
                                side: BorderSide()),
                            label: Text('$chip1'),
                            backgroundColor: const Color(0xFFFFFFF),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Chip(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.5)),
                                side: BorderSide()),
                            label: Text('$chip2'),
                            backgroundColor: const Color(0xFFFFFFF),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Chip(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.5)),
                                side: BorderSide()),
                            label: Text('$chip3'),
                            backgroundColor: const Color(0xFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Chip(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.5)),
                                side: BorderSide()),
                            label: Text('+ Add'),
                            backgroundColor: const Color(0xFFFFFFF),
                          ),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Row(
                                children: [
                                  Radio<members>(
                                    value: members.Prescription,
                                    groupValue: m,
                                    onChanged: (members? value) {},
                                  ),
                                  const Text('Prescription'),
                                ],
                              )),
                        ),
                        Expanded(
                          child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Row(
                                children: [
                                  Radio<members>(
                                    value: members.Test_Report,
                                    groupValue: m,
                                    onChanged: (members? value) {},
                                  ),
                                  const Text('Test Report'),
                                ],
                              )),
                        ),
                      ],
                    ),
                    ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Row(
                          children: [
                            Radio<members>(
                              value: members.Certificate,
                              groupValue: m,
                              onChanged: (members? value) {},
                            ),
                            const Text('Certificate'),
                          ],
                        )),

                    (imageList.length != 0)?

                        Padding(padding: EdgeInsets.only(bottom: 20, top: 20), child:
                    SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            Padding(padding: EdgeInsets.all(10.0), child:
                            Stack(
                            children: [
                              SizedBox(
                                  height: 100,
                                  child: Image.file(imageList[index])),
                              Align(alignment: Alignment.topRight,child:
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      imageList.removeAt(index);
                                    });
                                  },
                                ),
                              )
                                                          ],
                              ));
                        }),)):

                        SizedBox(

                        ),

                    //

                    OutlinedButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? ximage = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        File image = File(ximage!.path);

                        if (image != null) {
                          setState(() {

                            final bytes = image.readAsBytesSync().lengthInBytes;
                            final kb = bytes / 1024;

                            if(kb < 500) {
                              imageList.add(image);
                            }
                          });
                        }
                        print("Image List Length:" +
                            imageList!.length.toString());
                      },
                      child: Text('+ Add Document'),
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                            '* Size of Document should be less than 500 KB')),

                    Button(
                        text: 'Save',
                        onPress: () {},
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

  Future addImage() async {
    final ImagePicker _picker = ImagePicker();
    File image = (await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50)) as File;
    print('poi ' + image.toString());
    imageList.add(image);
  }
}

// String pdfUrl = result['pdfUrl'];
// OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
//         (result) => debugPrint(result.toString()));
