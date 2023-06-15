import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/services/remote_services.dart';

part 'all_subcategory_product_name_list_event.dart';
part 'all_subcategory_product_name_list_state.dart';

class AllSubcategoryProductNameListBloc extends Bloc<
    AllSubcategoryProductNameListEvent, AllSubcategoryProductNameListState> {
  String categoryname;
  AllSubcategoryProductNameListBloc({required this.categoryname})
      : super(AllSubcategoryProductNameListLoadingState()) {
    on<AllSubcategoryProductNameListLoadedEvent>((event, emit) async {
      try {

        emit(AllSubcategoryProductNameListLoadingState());
        var data = await Services().getSubCategroryList(categoryname);
        emit(AllSubcategoryProductNameListLoadedState(
            subcategorynameList: data));
      } catch (e) {
        emit(AllSubcategoryProductNameListErrorState());
      }
    });
  }
}
