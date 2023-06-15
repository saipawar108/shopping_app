import 'package:flutter/material.dart';
import 'package:shopping_app/consts/consts.dart';

Widget customTextField({title, hint, textEditingController, ispass}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      title,
      style: TextStyle(fontFamily: semibold, color: redColor, fontSize: 16),
    ),
    5.heightBox,
    TextFormField(
      obscureText: ispass,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(fontFamily: semibold, color: textfieldGrey),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: redColor))),
    ),
  ]);
}
