part of 'all_category_products_bloc.dart';

@immutable
abstract class AllCategoryProductsState {}

class AllCategoryProductsLoading extends AllCategoryProductsState {}

class AllCategoryProductsLoaded extends AllCategoryProductsState {
  final List<ProductModel> allCategoryProductList;
  AllCategoryProductsLoaded({required this.allCategoryProductList});
}

class AllCategoryProductsError extends AllCategoryProductsState {}
