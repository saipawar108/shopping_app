import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/colors.dart';
import '../../../consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      "00".text.fontFamily(bold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .height(80)
      .rounded
      .width(width)
      .padding(const EdgeInsets.all(4))
      .make();
}
