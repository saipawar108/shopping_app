import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/screens/accountScreen/account.dart';
import 'package:shopping_app/screens/cartScreen/cart.dart';
import 'package:shopping_app/screens/categoryScreen/catergory.dart';
import 'package:shopping_app/screens/homeScreen/homeScreen.dart';
import 'package:shopping_app/screens/loginScreen/loginScreen.dart';
import 'package:shopping_app/screens/signupScreen/signupScreen.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';

import '../../Controllers/homeController.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());
  var navBarItem = [
    BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: categories),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account),
  ];
  var navBody = [HomeScreen(), CategoryScreen(), CartScreen(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value)))
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
            items: navBarItem),
      ),
    );
  }
}
