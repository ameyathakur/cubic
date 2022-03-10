import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cubic/UI/SplashScreen.dart';
import 'package:cubic/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add the following line to add API plugin to your app
    Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));

    try {
      await Amplify.configure(amplifyconfig);

      try {
        Todo todo = Todo(
            name: 'my second todo',
            id: 'dsdmskaaama',
            dob: "nskdna",
            emaild_id: "sndjad",
            contact_no: "knjasnd",
            adhar_no: "dnjsan",
            gender: "kmdknas");
        final request = ModelMutations.create(todo);
        final response = await Amplify.API.mutate(request: request).response;

        Todo? createdTodo = response.data;
        if (createdTodo == null) {
          print('errors: ' + response.errors.toString());
          return;
        }
        print('Mutation result: ' + createdTodo.name);
      } on ApiException catch (e) {
        print('Mutation failed: $e');
      }
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
