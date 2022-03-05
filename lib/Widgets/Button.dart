import 'package:flutter/material.dart';

import '../UI/OTPverification.dart';

class Button extends StatelessWidget {
  final String text;
  final GestureTapCallback onPress;
  final Color color, borderColor, textColor;

  const Button(
      {Key? key,
      required this.text,
      required this.onPress,
      required this.color,
      required this.borderColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPress,
        child: Text(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          primary: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(width: 2, color: borderColor),
        ));
  }
}
