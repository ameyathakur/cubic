import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String title, subtitle;

  const DetailsRow({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                SizedBox(
                    width: 125,
                    child: Text(
                      title,
                      style: TextStyle(fontFamily: 'Roboto'),
                    )),
                Expanded(
                    // width: 125,
                    child: Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontFamily: 'Roboto'),
                ))
              ],
            )));
  }
}
