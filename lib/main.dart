import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'UI/SplashScreen.dart';
import 'UI/UserDetails.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    _configureAmplify();
  }
  Future <void> _configureAmplify()async{
    try{
      AmplifyAuthCognito amplifyAuthCognito= AmplifyAuthCognito();
      AmplifyAPI amplifyAPI=AmplifyAPI();
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.addPlugin(AmplifyAPI());
      await Amplify.configure(amplifyconfig);

    }on Exception catch(e){
      print('Error Occured while adding amplify configure');
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new SplashScreen(),
    );
  }
}
