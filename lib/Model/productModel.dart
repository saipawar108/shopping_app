//
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String id;
  int productModelId;
  String name;
  String? description;
  double? rating;
  Category category;
  String subcategory;
  double currentPrice;
  int discount;
  int likesCount;
  String brand;
  String variation0Thumbnail;
  String variation0Color;
  String variation0Image;
  String variation1Color;
  String variation1Thumbnail;
  String variation1Image;
  String imageUrl;
  Codcountry codcountry;
  List<Review> reviews;

  ProductModel({
    required this.id,
    required this.productModelId,
    required this.name,
    this.description,
    this.rating,
    required this.category,
    required this.subcategory,
    required this.currentPrice,
    required this.discount,
    required this.likesCount,
    required this.brand,
    required this.variation0Thumbnail,
    required this.variation0Color,
    required this.variation0Image,
    required this.variation1Color,
    required this.variation1Thumbnail,
    required this.variation1Image,
    required this.imageUrl,
    required this.codcountry,
    required this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        productModelId: json["id"],
        name: json["name"],
        description: json["description"],
        rating: json["rating"]?.toDouble(),
        category: categoryValues.map[json["category"]]!,
        subcategory: json["subcategory"],
        currentPrice: json["current_price"]?.toDouble(),
        discount: json["discount"],
        likesCount: json["likes_count"],
        brand: json["brand"],
        variation0Thumbnail: json["variation_0_thumbnail"],
        variation0Color: json["variation_0_color"],
        variation0Image: json["variation_0_image"],
        variation1Color: json["variation_1_color"],
        variation1Thumbnail: json["variation_1_thumbnail"],
        variation1Image: json["variation_1_image"],
        imageUrl: json["image_url"],
        codcountry: codcountryValues.map[json["codcountry"]]!,
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": productModelId,
        "name": name,
        "description": description,
        "rating": rating,
        "category": categoryValues.reverse[category],
        "subcategory": subcategory,
        "current_price": currentPrice,
        "discount": discount,
        "likes_count": likesCount,
        "brand": brand,
        "variation_0_thumbnail": variation0Thumbnail,
        "variation_0_color": variation0Color,
        "variation_0_image": variation0Image,
        "variation_1_color": variation1Color,
        "variation_1_thumbnail": variation1Thumbnail,
        "variation_1_image": variation1Image,
        "image_url": imageUrl,
        "codcountry": codcountryValues.reverse[codcountry],
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

enum Category { JEWELRY, KIDS, BEAUTY, ACCESSORIES, MEN, WOMEN, SHOES }

final categoryValues = EnumValues({
  "accessories": Category.ACCESSORIES,
  "beauty": Category.BEAUTY,
  "jewelry": Category.JEWELRY,
  "kids": Category.KIDS,
  "men": Category.MEN,
  "shoes": Category.SHOES,
  "women": Category.WOMEN
});

enum Codcountry { ID_MY_PH_SG_TH_VN, EMPTY, PH_TH_VN }

final codcountryValues = EnumValues({
  "": Codcountry.EMPTY,
  "ID,MY,PH,SG,TH,VN": Codcountry.ID_MY_PH_SG_TH_VN,
  "PH,TH,VN": Codcountry.PH_TH_VN
});

class Review {
  double? reviewRating;
  String? reviewTitle;
  dynamic? reviewDate;
  String? reviewContent;

  Review({
    this.reviewRating,
    this.reviewTitle,
    this.reviewDate,
    this.reviewContent,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewRating: json["review_rating"]?.toDouble(),
        reviewTitle: json["review_title"],
        reviewDate: json["review_date"],
        reviewContent: json["review_content"],
      );

  Map<String, dynamic> toJson() => {
        "review_rating": reviewRating,
        "review_title": reviewTitle,
        "review_date": reviewDate,
        "review_content": reviewContent,
      };
}

enum ReviewDateEnum {
  THE_2021111,
  THE_2021141,
  THE_2021121,
  THE_2012051,
  THE_2011051
}

final reviewDateEnumValues = EnumValues({
  "2011-05-1": ReviewDateEnum.THE_2011051,
  "2012-05-1": ReviewDateEnum.THE_2012051,
  "2021-11-1": ReviewDateEnum.THE_2021111,
  "2021-12-1": ReviewDateEnum.THE_2021121,
  "2021-14-1": ReviewDateEnum.THE_2021141
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
