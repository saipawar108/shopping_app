import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Controllers/productController.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/consts/image_list.dart';
import 'package:shopping_app/screens/categoryScreen/review.dart';
import 'package:shopping_app/widgets/button.dart';

import '../../Model/productModel.dart';

class ItemsDetails extends StatefulWidget {
  final List<ProductModel> products;
  final int index;
  final String image;
  const ItemsDetails(
      {Key? key,
     required this.products,
      required this.index,
      required this.image})
      : super(key: key);

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: widget.products[widget.index].name.text
              .color(darkFontGrey)
              .fontFamily(bold)
              .make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
              color: darkFontGrey,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
              color: darkFontGrey,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swiper section
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Image.network(widget.image,
                                width: double.infinity, fit: BoxFit.cover);
                          }),
                      10.heightBox,
                      //title and details
                      widget.products[widget.index].name.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      VxRating(
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        stepInt: true,
                      ),
                      10.heightBox,
                      widget.products[widget.index].currentPrice.text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              10.heightBox,
                              "In house Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make()
                            ],
                          )),
                          const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,
                                  color: darkFontGrey))
                        ],
                      )
                          .box
                          .height(60)
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      //color selection
                      20.heightBox,
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    3,
                                    (index) => VxBox()
                                        .size(35, 35)
                                        .roundedFull
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 6))
                                        .color(Vx.randomPrimaryColor)
                                        .make()),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove)),
                                  "0"
                                      .text
                                      .size(16)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.add)),
                                  10.widthBox,
                                  "(0 available)"
                                      .text
                                      .color(textfieldGrey)
                                      .make()
                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 110,
                                child: "Total Price: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              SizedBox(
                                width: 100,
                                child: widget
                                    .products[widget.index].currentPrice.text
                                    .size(16)
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                              ),
                            ],
                          )
                              .box
                              .color(golden)
                              .padding(const EdgeInsets.all(8))
                              .make(),
                        ],
                      ).box.white.shadowSm.make(),
                      10.heightBox,
                      // Description section
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      widget.products[widget.index].description!.text
                          .color(darkFontGrey)
                          .make(),
                      //Button section
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailsButtons.length,
                            (index) => ListTile(
                                  title: itemDetailsButtons[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                  onTap: () {
                                    if (index == 1) {
                                      print(
                                          "tags.here ${widget.products[index].name}");
                                      Get.to(() => Reviews(
                                            productModel: widget
                                                .products[this.widget.index],
                                          ));
                                    }
                                  },
                                )),
                      ),
                      10.heightBox,
                      productyoumayalsolike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(imgP1,
                                          width: 150, fit: BoxFit.cover),
                                      10.heightBox,
                                      "Laptop 4GB/64GB"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .size(18)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 4))
                                      .padding(EdgeInsets.all(8))
                                      .make()),
                        ),
                      )
                    ]),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: " Add to cart",
              ),
            )
          ],
        ));
  }
}
