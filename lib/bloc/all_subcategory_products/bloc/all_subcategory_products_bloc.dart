import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Model/productModel.dart';
import '../../../services/remote_services.dart';

part 'all_subcategory_products_event.dart';
part 'all_subcategory_products_state.dart';

class AllSubcategoryProductsBloc
    extends Bloc<AllSubcategoryProductsEvent, AllSubcategoryProductsState> {
  String subcategoryname;
  AllSubcategoryProductsBloc({required this.subcategoryname})
      : super(AllSubcategoryProductLoadingState()) {
    on<AllSubcategoryProductLoadedEvent>((event, emit) async {
      try {
        emit(AllSubcategoryProductLoadingState());
        print("tags.subcategoryBloc $subcategoryname");
        var data = await Services().getSubCategoryProducts(subcategoryname);
        emit(AllSubcategoryProductLoadedState(subcategoryproducts: data));
      } catch (e) {
        emit(AllSubcategoryProductErrorState());
      }
    });
  }
}
