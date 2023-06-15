import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/bloc/all_category_products/bloc/all_category_products_bloc.dart';
import 'package:shopping_app/consts/consts.dart';
import '../../bloc/all_subcategory_products/bloc/all_subcategory_products_bloc.dart';
import 'items_details.dart';

Widget subcategory({title, required String selectedchip}) {
  return selectedchip.isEmpty
      ? BlocProvider(
          create: (context) => AllCategoryProductsBloc(category: title)
            ..add(AllCategoryProductsLoadedEvent()),
          child: BlocBuilder<AllCategoryProductsBloc, AllCategoryProductsState>(
              builder: (context, state) {
            print("tags.selectedchip is empty ${selectedchip}");
            if (state is AllCategoryProductsLoading) {
              print("tags.inif55");
              return const Center(child: CircularProgressIndicator());
            } else if (state is AllCategoryProductsLoaded) {
              print("tags.inif2");
              var loadedproduct = state;
              return Expanded(
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedproduct.allCategoryProductList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                                loadedproduct
                                    .allCategoryProductList[index].imageUrl,
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover),
                            Expanded(
                              flex: 1,
                              child: loadedproduct
                                  .allCategoryProductList[index].name.text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(18)
                                  .make(),
                            ),
                            10.heightBox,
                            loadedproduct
                                .allCategoryProductList[index].currentPrice.text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                            .outerShadowSm
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .padding(EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemsDetails(
                                index: index,
                                image: loadedproduct
                                    .allCategoryProductList[index].imageUrl,
                                products: loadedproduct.allCategoryProductList,
                              ));
                        });
                      }));
            } else {
              return const Center(child: Text("Error"));
            }
          }))
      : BlocProvider(
          create: (context) =>
              AllSubcategoryProductsBloc(subcategoryname: selectedchip)
                ..add(AllSubcategoryProductLoadedEvent()),
          child: BlocBuilder<AllSubcategoryProductsBloc,
              AllSubcategoryProductsState>(builder: (context, state) {
            print("Tags.INSUBCATEGORY");
            if (state is AllSubcategoryProductLoadingState) {
              print(
                  "tags.chipsnotemptyAllsubcategoryLoadingState ${selectedchip}");
              return const Center(child: CircularProgressIndicator());
            } else if (state is AllSubcategoryProductLoadedState) {
              print("tags.chipsnotemptyLoadedState ${selectedchip}");
              var loadedproduct = state;
              print(
                  "tags.chipsnotemptyLoadedState ${loadedproduct.subcategoryproducts.length}");
              return Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedproduct.subcategoryproducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                                loadedproduct
                                    .subcategoryproducts[index].imageUrl,
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover),
                            Expanded(
                              flex: 1,
                              child: loadedproduct
                                  .subcategoryproducts[index].name.text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(18)
                                  .make(),
                            ),
                            10.heightBox,
                            loadedproduct
                                .subcategoryproducts[index].currentPrice.text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                            .outerShadowSm
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemsDetails(
                                index: index,
                                image: loadedproduct
                                    .subcategoryproducts[index].imageUrl,
                                products: loadedproduct.subcategoryproducts,
                              ));
                        });
                      }));
            } else {
              return const Center(child: Text("Error"));
            }
          }),
        );
}
