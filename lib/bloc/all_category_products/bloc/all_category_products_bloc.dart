import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/Model/productModel.dart';
import 'package:shopping_app/services/remote_services.dart';

part 'all_category_products_event.dart';
part 'all_category_products_state.dart';

class AllCategoryProductsBloc
    extends Bloc<AllCategoryProductsEvent, AllCategoryProductsState> {
  String category;
  AllCategoryProductsBloc({required this.category})
      : super(AllCategoryProductsLoading()) {
    on<AllCategoryProductsLoadedEvent>((event, emit) async {
      try {
        emit(AllCategoryProductsLoading());
        var data = await Services().getCategoryProducts(category);
        print("tags.allcategory${data}");
        emit(AllCategoryProductsLoaded(allCategoryProductList: data));
      } catch (e) {
        emit(AllCategoryProductsError());
      }
    });
  }
}
