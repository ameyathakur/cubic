import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/material.dart';

String chip1 = 'Tag 1', chip2 = 'Tag 2', chip3 = 'Tag 3';

enum members { Prescription, Test_Report, Certificate }
members m = members.Prescription;

class AddDocument extends StatelessWidget {
  const AddDocument({Key? key}) : super(key: key);

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
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                            '* Size of Document should be less than 500 KB')),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Button(
                              text: 'Upload',
                              onPress: () {},
                              color: const Color(0XFF208FEE),
                              borderColor: const Color(0XFF208FEE),
                              textColor: Colors.white,
                            ))),
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
}
