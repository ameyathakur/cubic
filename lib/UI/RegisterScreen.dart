import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/UI/PaymentScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../amplifyconfiguration.dart';
import '../models/ModelProvider.dart';

TextEditingController email = new TextEditingController(),
    contact = new TextEditingController();

List nameControllers = <TextEditingController>[],
    genderControllers = <TextEditingController>[],
    dobControllers = <TextEditingController>[],
    adharControllers = <TextEditingController>[];

String dob = "";

var widgets = <Widget>[];

var oneVisibility = false,
    twoVisibility = false,
    threeVisibility = false,
    fourVisibility = false,
    fiveVisibility = false;

List<String> genders = <String>[
  'Select Gender',
  'Male',
  'Female',
  'Prefer not to say'
];

List selectedGenders = <String>[];

String selectedValue = 'Select Gender';

TextStyle defaultStyle = TextStyle(color: Colors.black);
TextStyle linkStyle = TextStyle(color: const Color(0XFF0000FF));

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
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
                              controller: nameControllers[0],
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
                              controller: contact,
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
                              controller: email,
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
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGenders[0];
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
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: TextField(
                                    controller: nameControllers[0],
                                    showCursor: false,
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
                                          dobControllers[0].text =
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
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: TextField(
                              controller: nameControllers[0],
                              showCursor: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  hintText: 'Aadhar No.',
                                  border: InputBorder.none),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widgets,
                          )),
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    widgets.add(Column(children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: TextField(
                                              controller: nameControllers.last,
                                              showCursor: false,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10.0),
                                                  hintText: 'Name',
                                                  border: InputBorder.none),
                                            ),
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 20),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: TextField(
                                              controller: nameControllers.last,
                                              showCursor: false,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10.0),
                                                  hintText: 'Relation',
                                                  border: InputBorder.none),
                                            ),
                                          )),
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
                                                    controller:
                                                        dobControllers.last,
                                                    showCursor: false,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10.0),
                                                        border:
                                                            InputBorder.none),
                                                    onTap: () {
                                                      showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1900, 1),
                                                        lastDate:
                                                            DateTime.now(),
                                                      ).then((pickedDate) {
                                                        setState(() {
                                                          var date = DateTime
                                                              .parse(pickedDate
                                                                  .toString());
                                                          var formattedDate =
                                                              "${date.day}-${date.month}-${date.year}";
                                                          dobControllers
                                                                  .last.text =
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
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                  hint: Text(
                                                    'Select Item',
                                                  ),
                                                  items: genders
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: selectedValue,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedGenders
                                                          .add(newValue);
                                                    });
                                                  })),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 10, 20),
                                              color: Colors.red,
                                              onPressed: () {
                                                setState(() {
                                                  widgets.removeLast();
                                                });
                                              },
                                              icon: Icon(Icons.delete)))
                                    ]));
                                  });
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
                      Button(
                          text: 'Register',
                          onPress: () async {
                            // Add the following line to add API plugin to your app
                            if (!Amplify.isConfigured) {
                              Amplify.addPlugin(AmplifyAPI(
                                  modelProvider: ModelProvider.instance));

                              await Amplify.configure(amplifyconfig);
                            }

                            try {
                              try {
                                List membersList = <Member>[];
                                for (int i = 0;
                                    i < nameControllers.length;
                                    i++) {
                                  Member member = Member(
                                      id: 'ksmksmsk',
                                      name: nameControllers[i].toString(),
                                      gender: genderControllers[i].toString(),
                                      dob: dobControllers[i].toString(),
                                      adhar_no: adharControllers[i].toString());
                                  membersList.add(member);
                                }

                                User user = User(
                                    id: 'nsdhjsnbdjdnjd',
                                    emaild_id: email.text,
                                    contact_no: contact.text,
                                    members: List<Member>.from(membersList
                                        .where((i) => i.flag == true)));
                                final request = ModelMutations.create(user);
                                final response = await Amplify.API
                                    .mutate(request: request)
                                    .response;

                                User? createdUser = response.data;
                                if (createdUser == null) {
                                  print(
                                      'errors: ' + response.errors.toString());
                                  return;
                                }
                                print('Mutation result: ' + createdUser.id);
                              } on ApiException catch (e) {
                                print('Mutation failed: $e');
                              }
                            } on AmplifyAlreadyConfiguredException {
                              print(
                                  "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
                            }

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaymentScreen()));
                          },
                          color: const Color(0XFF208FEE),
                          borderColor: const Color(0XFF208FEE),
                          textColor: Colors.white)
                    ],
                  ))),
        ],
      ),
    );
  }
}
