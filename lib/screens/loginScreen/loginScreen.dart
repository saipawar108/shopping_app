import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/providers/user_provider.dart';
import 'package:shopping_app/screens/homeScreen/home.dart';
import 'package:shopping_app/screens/signupScreen/signupScreen.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textField.dart';
import 'package:shopping_app/consts/image_list.dart';
import '../../services/remote_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  putData(String email, String password,BuildContext context) async {
    String token = await Services().loginUser(email, password,context);
    print("tag.here2");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingControllerLoginEmail =
        TextEditingController();
    TextEditingController textEditingControllerLoginPassword =
        TextEditingController();
    return bgWidget(Scaffold(
        body: Center(
            child: Column(children: [
      (context.screenHeight * 0.1).heightBox,
      applogo(),
      10.heightBox,
      "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
      10.heightBox,
      Column(
        children: [
          customTextField(
              ispass: false,
              title: email,
              hint: hintEmail,
              textEditingController: textEditingControllerLoginEmail),
          20.heightBox,
          customTextField(
              ispass: true,
              title: password,
              hint: hintpassword,
              textEditingController: textEditingControllerLoginPassword),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: forgetpassword.text.make())),
          5.heightBox,
          ourButton(
              color: redColor,
              title: login,
              textColor: whiteColor,
              onPress: () async {
                String error = await putData(
                    textEditingControllerLoginEmail.text,
                    textEditingControllerLoginPassword.text,context);
                SnackBar snackBar = SnackBar(
                  content: Text(error),
                );
                print("tag.here3");
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }).box.width(context.screenWidth - 50).make(),
          5.heightBox,
          createNewAccount.text.color(fontGrey).make(),
          5.heightBox,
          ourButton(
              color: golden,
              title: signup,
              textColor: redColor,
              onPress: () {
                Get.to(() => const SignUpScreen());
                print("sign up");
              }).box.width(context.screenWidth - 50).make(),
          10.heightBox,
          loginwith.text.color(fontGrey).make(),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(
                          image_list[index],
                          width: 30,
                        ),
                      ),
                    )),
          )
        ],
      )
          .box
          .white
          .rounded
          .padding(const EdgeInsets.all(16))
          .width(context.screenWidth - 70)
          .make(),
    ]))));
  }
}
