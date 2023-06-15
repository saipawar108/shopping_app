import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Model/productModel.dart';
import 'package:shopping_app/services/remote_services.dart';
part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsLoadingState()) {
    on<AllProductsInitialEvent>((event, emit) async {
      try {
        emit(AllProductsLoadingState());
        print("tags.bloc1");
        var data = await Services().getProducts();
        print("tags.bloc ${data}");
        emit(AllProductsLoadedState(allproducts: data));
      } catch (e) {
        emit(AllProductsErrorState());
      }
    });
  }
}
