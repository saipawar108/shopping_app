part of 'all_products_bloc.dart';

@immutable
abstract class AllProductsState {}

class AllProductsLoadingState extends AllProductsState {}

class AllProductsLoadedState extends AllProductsState {
  final List<ProductModel> allproducts;
  AllProductsLoadedState({required this.allproducts});
}

class AllProductsErrorState extends AllProductsState {}
