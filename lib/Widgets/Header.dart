import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title, subtitle;

  const Header({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 194.0,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: const Color(0xFFFFBD59)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 47, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: 'Roboto'),
            ),
          )
        ],
      ),
    );
  }
}
