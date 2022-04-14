import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubic/UI/AddDocument.dart';
import 'package:cubic/Widgets/Button.dart';
import 'package:cubic/Widgets/DetailsRow.dart';
import 'package:cubic/Widgets/VerticalBar.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';
import 'OTPverification.dart';

//Variables of details
String name = 'Name of the User',
    disease = 'Illness',
    docName = 'Name of the Doctor',
    date = 'Date of Visit',
    comments = 'Comments by the user';

class documentDetails extends StatefulWidget {

  final DocumentSnapshot documentSnapshot;
  documentDetails({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<documentDetails> createState() => _documentDetailsState();
}

class _documentDetailsState extends State<documentDetails> {

  List tags = [];
  List imageUrls = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tags = widget.documentSnapshot.get('tags');
    imageUrls = widget.documentSnapshot.get('images');
  }

  @override
  Widget build(BuildContext context) {

    print("sari " + imageUrls.toString());
    height: MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Row(
          children: [
            Container(
              child: Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top : 30), child: BackButton(onPressed: (){
                Navigator.pop(context);
              },))),
              width: 73.0,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFFFFBD59),
            ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Stack(
                    children: [

                      (imageUrls.length > 0)?
                      CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => imageDialog(imageUrls[itemIndex])
                                    );
                                  },
                                child: CachedNetworkImage(
                                  imageUrl: imageUrls[itemIndex],
                                  placeholder: (context, url) => Container(width:10, height:10, child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ))),
                        options: CarouselOptions(
                        height: 200,
                      ),
                      ):Text('No Images Added'),
                    ],
                  )),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10, bottom: 10),
                  color: const Color(0xFFF1EBEB),
                  child: Row(children: [
                    Text(
                      'Details:',
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
                    ),
                    // Expanded(
                    //   child: Align(
                    //       alignment: Alignment.centerRight,
                    //       child: Button(
                    //           text: 'Edit',
                    //           onPress: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (BuildContext context) =>
                    //                         AddDocument()));
                    //           },
                    //           color: Color(0xFFCFC9C9),
                    //           borderColor: Colors.black,
                    //           textColor: Colors.black)),
                    // ),
                  ])),
              DetailsRow(title: "Patient's Name:", subtitle: (
                      widget.documentSnapshot.data() as Map<String, dynamic>)['name']),
              DetailsRow(title: "Illness:", subtitle:  (
                  widget.documentSnapshot.data() as Map<String, dynamic>)['illness']),
              DetailsRow(title: "Doctor's Name:", subtitle:  (
                  widget.documentSnapshot.data() as Map<String, dynamic>)['doctor']),
              DetailsRow(title: "Date", subtitle:  (
                  widget.documentSnapshot.data() as Map<String, dynamic>)['date of visit']),
              DetailsRow(title: "Comments:", subtitle:  (
                  widget.documentSnapshot.data() as Map<String, dynamic>)['comments']),
              Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: tags
                        .map(
                          (element) => Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7.5)),
                            side: BorderSide()),
                        label: Text(element),
                        backgroundColor: const Color(0xFFFFFFF),
                      ),
                    ).toList(),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'Assets/logo_rectangular.png',
                      width: 100.0,
                    )),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}

Widget imageDialog(path) {return Dialog(
      child: Expanded(
        child: CachedNetworkImage(
          imageUrl: path,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        )
      ),
    );
  }
