import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/providers/user_provider.dart';
import 'package:shopping_app/screens/homeScreen/home.dart';
import 'package:shopping_app/screens/loginScreen/loginScreen.dart';
import 'package:shopping_app/services/remote_services.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), (() {
      print("here after api${Provider.of<UserProvider>(context, listen: false).getuser.email}");
      Get.to(() => Provider.of<UserProvider>(context).getuser.token.isNotEmpty
          ? const LoginScreen()
          : Home());
    }));
  }

  @override
  void initState() {
    Services().getUserData(context);
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              icSplashBg,
              width: 300,
            ),
          ),
          20.heightBox,
          applogo(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox
        ]),
      ),
    );
  }
}
