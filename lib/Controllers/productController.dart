import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../Model/productModel.dart';
import '../services/remote_services.dart';

class ProductController extends GetxController {
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  var isLoading = true.obs;
  var productlist = <ProductModel>[];
  List<String> categorylist = [];
  var reviews = <Review>[];
  var allProductsofDifferentCategory = <ProductModel>[];
  var subcategoryProductList = <ProductModel>[];

//List of all products
  void fetchProducts() async {
    isLoading(true);
    try {
      List<ProductModel> products = await Services().getProducts();
      if (products != null) {
        productlist = products.cast<ProductModel>();
        print("tags.productList ${productlist}");
        update();
      }
    } finally {
      isLoading(false);
    }
  }

//List of all reviews
  void fetchReviewsById(String id) async {
    isLoading(true);
    try {
      List<Review> review = await Services().getAllReviewsById(id);
      if (reviews != null) {
        reviews = review.cast<Review>();
        print("tags.reviews ${reviews}");
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  //list of all category

  void fetchCategoryList(String category) async {
    isLoading(true);
    try {
      List<String> list = await Services().getSubCategroryList(category);
      categorylist = list;
      print("tags.category ${categorylist}");
      update();
    } finally {
      isLoading(false);
    }
  }

  //list of all subcategory products

  void fetchSubcategoryProducts(String subcategory) async {
    isLoading(true);
    try {
      List<ProductModel> products =
          await Services().getSubCategoryProducts(subcategory);
      if (products != null) {
        subcategoryProductList = products.cast<ProductModel>();
        print("tags.subcategoryproducts ${subcategoryProductList}");
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  //list of all category products

  void fetchCategoryProducts(String category) async {
    isLoading(true);
    try {
      List<ProductModel> womenproducts =
          await Services().getCategoryProducts(category);
      if (womenproducts != null) {
        allProductsofDifferentCategory = womenproducts.cast<ProductModel>();
        print("tags.categoryproducts$womenproducts");
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}
