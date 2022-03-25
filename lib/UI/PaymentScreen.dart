import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/UI/MainScreen.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:flutter/material.dart';

import '../Custom Models/MemberModel.dart';
import '../models/User.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  List<dynamic> subusers = [];
  List<MemberModel> membersi = [];
  Map<String, bool> names = {};
  int price = 0;
  late User user;

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
      user = userResponse.data!;
      if (user == null) {
        print('errors: ' + userResponse.errors.toString());
      }

      setState(() {

        String? membes = user?.members;

        subusers = jsonDecode(membes!);

        Iterable l = json.decode(membes);
        membersi = List<MemberModel>.from(
            l.map((model) => MemberModel.fromJson(model)));

        for(int i=0; i<membersi.length; i++){
          names[membersi[i].name] = true;
        }

        for(var k in names.values){
          if(k == true){
            price+=499;
          }
        }
      });
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Row(children: [
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
                      new ListView(
                        shrinkWrap: true,
                        children: names.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: names[key],
                            onChanged: (val){
                              setState(() {
                                names[key] = val!;
                                if(val == false){
                                  price -= 499;
                                }
                                else{
                                  price+=499;
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      Button(
                          text: 'Pay ' + price.toString(),
                          onPress: () async {

                            // for(int i=0; i<membersi.length; i++){
                            //   if(names[membersi[i].name] == true){
                            //     membersi[i].subscribed = true;
                            //   }
                            //   else{
                            //     membersi[i].subscribed = false;
                            //   }
                            // }
                            //
                            // var json = jsonEncode(
                            //     membersi.map((e) => e.toJson()).toList());
                            //
                            // User newUser = user.copyWith(members: json);
                            //
                            // final request = ModelMutations.update(newUser);
                            // final response = await Amplify.API.mutate(request: request).response;
                            //
                            // print("jk " + response.data.toString());

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen()));
                          },
                          color: const Color(0XFF208FEE),
                          borderColor: const Color(0XFF208FEE),
                          textColor: Colors.white),
                    ],
                  ))),
        ])
    );

  }
}

