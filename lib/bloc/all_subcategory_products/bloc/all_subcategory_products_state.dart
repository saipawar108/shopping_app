part of 'all_subcategory_products_bloc.dart';

@immutable
abstract class AllSubcategoryProductsState {}

class AllSubcategoryProductLoadingState extends AllSubcategoryProductsState {}

class AllSubcategoryProductLoadedState extends AllSubcategoryProductsState {
 final List<ProductModel> subcategoryproducts;
  AllSubcategoryProductLoadedState({required this.subcategoryproducts});
}

class AllSubcategoryProductErrorState extends AllSubcategoryProductsState {}
