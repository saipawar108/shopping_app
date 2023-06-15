import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  int? wishlistCount;
  int? orderCount;
  int? cartCount;
  String name;
  String email;
  String? image;
  String token;
  UserData({
    this.wishlistCount,
    this.orderCount,
    this.cartCount,
    required this.name,
    required this.email,
    this.image,
    required this.token
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        wishlistCount: json["wishlist_count"],
        orderCount: json["order_count"],
        cartCount: json["cart_count"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        token:json['token']
      );

  Map<String, dynamic> toJson() => {
        "wishlist_count": wishlistCount,
        "order_count": orderCount,
        "cart_count": cartCount,
        "name": name,
        "email": email,
        "image": image,
      };
}
