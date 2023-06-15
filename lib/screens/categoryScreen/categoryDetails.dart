import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shopping_app/Model/productModel.dart';
import 'package:shopping_app/bloc/all_category_products/bloc/all_category_products_bloc.dart';
import 'package:shopping_app/bloc/all_subcategory_products/bloc/all_subcategory_products_bloc.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/screens/categoryScreen/items_details.dart';
import 'package:shopping_app/screens/categoryScreen/subcategoryItems.dart';
import 'package:shopping_app/services/remote_services.dart';
import 'package:shopping_app/widgets/bg_widget.dart';

import '../../Controllers/productController.dart';
import '../../bloc/all_subcategory_ProductsNameList/bloc/all_subcategory_product_name_list_bloc.dart';

class CategoryDetails extends StatefulWidget {
  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<String>? selectedSubcategory = [];
  bool isclicked = false;

  @override
  void initState() {
    print("tags.incategory");
    super.initState();
  }

  void printNotIncluded(List<String> completeList, List<String> selectedItems) {
    List<String> notIncludedItems = [];
    for (String item in completeList) {
      if (!selectedItems.contains(item)) {
        notIncludedItems.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllSubcategoryProductNameListBloc(categoryname: widget.title)
            ..add(AllSubcategoryProductNameListLoadedEvent()),
      child: bgWidget(Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(children: [
          BlocBuilder<AllSubcategoryProductNameListBloc,
              AllSubcategoryProductNameListState>(
            builder: (context, state) {
              if (state is AllSubcategoryProductNameListLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AllSubcategoryProductNameListLoadedState) {
                final loadedState = state;
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Wrap(
                          children: loadedState.subcategorynameList.map(
                            (hobby) {
                              bool isSelected = false;
                              if (selectedSubcategory!.contains(hobby)) {
                                isSelected = true;
                              }
                              return GestureDetector(
                                onTap: () {
                                  if (!selectedSubcategory!.contains(hobby)) {
                                    if (selectedSubcategory!.length < 1) {
                                      selectedSubcategory!.add(hobby);
                                      setState(() {});
                                      print(
                                          "tags.selectedSubcategory is not empty ${selectedSubcategory![0]}");
                                    }
                                  } else {
                                    selectedSubcategory!.removeWhere(
                                        (element) => element == hobby);
                                    setState(() {});
                                    print(
                                        "tags.selectedSubcategory is removed");
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: isSelected ? golden : lightGrey,
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                            color:
                                                isSelected ? golden : lightGrey,
                                            width: 2)),
                                    child: Text(
                                      hobby,
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ));
              } else {
                return const Center(child: Text("Error"));
              }
            },
          ),
          selectedSubcategory!.isEmpty
              ? subcategory(title: widget.title, selectedchip: '')
              : subcategory(
                  title: widget.title, selectedchip: selectedSubcategory![0])
        ]),
      )),
    );
  }
}
