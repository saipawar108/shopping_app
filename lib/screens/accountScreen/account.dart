import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Controllers/profileController.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/consts/image_list.dart';
import 'package:shopping_app/screens/accountScreen/components/details_card.dart';
import 'package:shopping_app/screens/accountScreen/components/edit_profile.dart';
import 'package:shopping_app/widgets/bg_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(Scaffold(
        body: SafeArea(
      child: Column(children: [
        //edit profile button
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.edit,
            color: whiteColor,
          ),
        ).onTap(() {
          Get.to(() => const EditProfile());
        }),
        Row(
          children: [
            Image.asset(
              imgProfile2,
              width: 130,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.widthBox,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Dummy user".text.fontFamily(semibold).color(whiteColor).make(),
                "dummyuser@example.com"
                    .text
                    .fontFamily(semibold)
                    .color(whiteColor)
                    .make()
              ],
            )),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: whiteColor)),
                onPressed: () {},
                child: logout.text.fontFamily(semibold).white.make())
          ],
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            detailsCard(
                count: "00",
                title: "in your cart",
                width: context.screenWidth / 3.4),
            detailsCard(
                count: "32",
                title: "in Wish List",
                width: context.screenWidth / 3.4),
            detailsCard(
                count: "675",
                title: " your orders",
                width: context.screenWidth / 3.4)
          ],
        ),

        //buttons

        ListView.separated(
          shrinkWrap: true,
          itemCount: profileButtonsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(
                profileButtonIcons[index],
                width: 22,
              ),
              title: profileButtonsList[index]
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .make(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: lightGrey,
            );
          },
        )
            .box
            .shadowSm
            .white
            .margin(EdgeInsets.all(12))
            .padding(const EdgeInsets.symmetric(horizontal: 16))
            .rounded
            .make()
            .box
            .color(redColor)
            .make()
      ]),
    )));
  }
}
