import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

List<String> genders = <String>[
  'Gender',
  'Male',
  'Female',
  'Prefer not to say'
];

String selectedValue = 'Gender';
TextStyle defaultStyle = TextStyle(color: Colors.black);
TextStyle linkStyle = TextStyle(color: const Color(0XFF0000FF));

class AddDocument extends StatelessWidget {
  const AddDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 73.0,
            height: double.infinity,
            color: const Color(0xFFFFBD59),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
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
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: TextField(
                              showCursor: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  hintText: 'Contact No.',
                                  border: InputBorder.none),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: TextField(
                              showCursor: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  hintText: 'Email id',
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
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
                              value: selectedValue,
                              onChanged: (value) {},
                            ),
                          ),
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
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: TextField(
                              showCursor: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  hintText: 'Adhar No.',
                                  border: InputBorder.none),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text('Add Family Member',
                                    style: TextStyle(fontSize: 16.0))),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
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
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: TextField(
                              showCursor: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  hintText: 'Relation',
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
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
                              value: selectedValue,
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: RichText(
                            text: TextSpan(
                              style: defaultStyle,
                              children: <TextSpan>[
                                TextSpan(text: 'By clicking, you accept our '),
                                TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                        color: const Color(0XFF0000FF)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                            ),
                          )),
                      Align(
                        child: OutlinedButton(
                            onPressed: () {},
                            child: Text("Register"),
                            style: OutlinedButton.styleFrom(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              primary: Colors.white,
                              backgroundColor: const Color(0XFF208FEE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            )),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
