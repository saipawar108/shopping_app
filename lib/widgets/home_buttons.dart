import 'package:flutter/material.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/consts/images.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Container(
    child: Column(children: [
      50.heightBox,
      Image.asset(icon, width: 26),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ]),
  ).box.rounded.white.size(width, height).make();
}
