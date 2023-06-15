import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Controllers/profileController.dart';

import '../../../consts/consts.dart';
import '../../../widgets/bg_widget.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_textField.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Obx(
          () => Column(
            children: [
              controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 170,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                      File(controller.profileImagePath.value),
                      width: 170,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              20.heightBox,
              customTextField(
                  hint: usernamehint, title: username, ispass: false),
              customTextField(
                  hint: hintpassword, title: password, ispass: true),
              20.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {},
                  textColor: whiteColor,
                  title: "Save"),
            ],
          )
              .box
              .white
              .margin(
                  const EdgeInsetsDirectional.only(top: 50, start: 20, end: 20))
              .shadowSm
              .rounded
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50))
              .make(),
        ))));
  }
}
