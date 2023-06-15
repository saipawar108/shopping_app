import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textField.dart';

import '../../services/remote_services.dart';
import '../homeScreen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool ischeck = false;
  @override
  Widget build(BuildContext context) {
    var textEditingControllerSignupName =
        TextEditingController();
    var textEditingControllerSignupEmail =
        TextEditingController();
    var textEditingControllerSignupPassword =
        TextEditingController();
    var textEditingControllerSignupRetypePassword =
        TextEditingController();

    return bgWidget(Scaffold(
        body: Center(
            child: Column(children: [
      (context.screenHeight * 0.1).heightBox,
      applogo(),
      10.heightBox,
      "Sign up to $appname".text.fontFamily(bold).white.size(18).make(),
      10.heightBox,
      Column(children: [
        customTextField(
            ispass: false,
            title: username,
            hint: usernamehint,
            textEditingController: textEditingControllerSignupName),
        10.heightBox,
        customTextField(
            ispass: false,
            title: email,
            hint: hintEmail,
            textEditingController: textEditingControllerSignupEmail),
        10.heightBox,
        customTextField(
            ispass: true,
            title: password,
            hint: hintpassword,
            textEditingController: textEditingControllerSignupPassword),
        10.heightBox,
        customTextField(
            ispass: true,
            title: retypepassword,
            hint: hintpassword,
            textEditingController: textEditingControllerSignupRetypePassword),
        10.heightBox,
        Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Checkbox(
                    value: ischeck,
                    onChanged: (value) {
                      setState(() {
                        ischeck = value!;
                      });
                    }),
                iagreetothe.text.make(),
                10.widthBox,
                Expanded(
                    child: termsandcondtion.text
                        .color(redColor)
                        .fontFamily(bold)
                        .make()),
              ],
            )),
        20.heightBox,
        ourButton(
            color: ischeck == true ? redColor : lightGrey,
            title: signup,
            textColor: ischeck == true ? lightGrey : redColor,
            onPress: () async {
              if (ischeck != false) {
                String error = await Services().signupinfo(
                    textEditingControllerSignupName.text,
                    textEditingControllerSignupEmail.text,
                    textEditingControllerSignupPassword.text,
                    textEditingControllerSignupRetypePassword.text);
                SnackBar snackBar = SnackBar(
                  content: Text(error),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }).box.width(context.screenWidth - 50).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {}, child: alreadyhaveaaccount.text.make()),
            TextButton(
                onPressed: () {}, child: login.text.color(redColor).make())
          ],
        )
      ])
          .box
          .white
          .rounded
          .padding(const EdgeInsets.all(16))
          .width(context.screenWidth - 70)
          .make(),
    ]))));
  }
}
