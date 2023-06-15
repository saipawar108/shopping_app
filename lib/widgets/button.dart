import 'package:flutter/material.dart';
import 'package:shopping_app/consts/consts.dart';

Widget ourButton({onPress, color, textColor, title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(fontFamily: bold, color: textColor),
      ));
}
