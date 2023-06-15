import 'package:flutter/material.dart';
import 'package:shopping_app/consts/consts.dart';

Container bgWidget(Widget widget) {
  return Container(
    child: widget,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
  );
}
