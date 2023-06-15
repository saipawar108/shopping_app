part of 'all_subcategory_product_name_list_bloc.dart';

@immutable
abstract class AllSubcategoryProductNameListState {}

class AllSubcategoryProductNameListLoadingState
    extends AllSubcategoryProductNameListState {}

class AllSubcategoryProductNameListLoadedState
    extends AllSubcategoryProductNameListState {
  final List<String> subcategorynameList;
  AllSubcategoryProductNameListLoadedState({required this.subcategorynameList});
}

class AllSubcategoryProductNameListErrorState
    extends AllSubcategoryProductNameListState {}
