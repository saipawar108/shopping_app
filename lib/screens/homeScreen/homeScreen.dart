import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/bloc/all_products_bloc/bloc/all_products_bloc.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/consts/image_list.dart';
import 'package:shopping_app/screens/homeScreen/components/featured_button.dart';
import 'package:shopping_app/services/remote_services.dart';

import '../../widgets/home_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AllProductsBloc productsBloc = AllProductsBloc();
  @override
  void initState() {
    productsBloc.add(AllProductsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            width: context.screenWidth - 20,
            alignment: Alignment.center,
            child: const TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: firstSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(firstSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysdeal : flashsale)),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategory
                                : index == 1
                                    ? brand
                                    : topsellers),
                      )),
                  //featured Categories
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredcategories.text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .size(22)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitles2[index])
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        BlocBuilder<AllProductsBloc, AllProductsState>(
                          builder: (context, state) {
                            if (state is AllProductsLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is AllProductsLoadedState) {
                              var allproductsloadedState = state;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      allproductsloadedState.allproducts.length,
                                      (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                  allproductsloadedState
                                                      .allproducts[index]
                                                      .imageUrl,
                                                  width: 110,
                                                  fit: BoxFit.cover),
                                              10.heightBox,
                                              allproductsloadedState
                                                  .allproducts[index].name.text
                                                  .fontFamily(semibold)
                                                  .color(darkFontGrey)
                                                  .size(18)
                                                  .ellipsis
                                                  .make(),
                                              10.heightBox,
                                              allproductsloadedState
                                                  .allproducts[index]
                                                  .currentPrice
                                                  .text
                                                  .color(redColor)
                                                  .fontFamily(bold)
                                                  .size(16)
                                                  .make()
                                            ],
                                          )
                                              .box
                                              .size(250, 250)
                                              .white
                                              .roundedSM
                                              .margin(EdgeInsets.symmetric(
                                                  horizontal: 4))
                                              .padding(EdgeInsets.all(8))
                                              .make()),
                                ),
                              );
                            } else {
                              return const Center(child: Text("Error"));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  BlocBuilder<AllProductsBloc, AllProductsState>(
                      builder: (BuildContext context, state) {
                    if (state is AllProductsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AllProductsLoadedState) {
                      final loadedState = state;
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: loadedState.allproducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 300,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                    loadedState.allproducts[index].imageUrl,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover),
                                const Spacer(),
                                Flexible(
                                  child: loadedState
                                      .allproducts[index].name.text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(18)
                                      .make(),
                                ),
                                10.heightBox,
                                loadedState.allproducts[index].currentPrice.text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .padding(EdgeInsets.all(12))
                                .make();
                          });
                    } else {
                      return const Center(child: Text("Error"));
                    }
                  })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
