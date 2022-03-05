import 'package:flutter/material.dart';

String chip1 = 'Tag 1', chip2 = 'Tag 2', chip3 = 'Tag 3';

enum members { Prescription, Test_Report, Certificate }
members m = members.Prescription;

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
                                  hintText: 'Illness',
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
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 10.0),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.5)),
                                  side: BorderSide()),
                              label: Text('+ Add'),
                              backgroundColor: const Color(0xFFFFFFF),
                            ),
                          )),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Prescription'),
                              leading: Radio<members>(
                                value: members.Prescription,
                                groupValue: m,
                                onChanged: (members? value) {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Test Report'),
                              leading: Radio<members>(
                                value: members.Test_Report,
                                groupValue: m,
                                onChanged: (members? value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: const Text('Certificate'),
                          leading: Radio<members>(
                            value: members.Certificate,
                            groupValue: m,
                            onChanged: (members? value) {},
                          ),
                        ),
                      ),
                      Text('* Size of Document should be less than 500 KB'),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                                onPressed: () {},
                                child: Text("Upload"),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  primary: Colors.white,
                                  backgroundColor: const Color(0XFF208FEE),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                )),
                          )),
                      Align(
                        child: OutlinedButton(
                            onPressed: () {},
                            child: Text("Save"),
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
