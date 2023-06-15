import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/providers/user_provider.dart';
import '../Model/productModel.dart';
import '../screens/homeScreen/home.dart';

class Services {
  loginUser(String email, String password, BuildContext context) async {
    try {
      final uri = Uri.parse('$uristring/user/login');
      Map<String, dynamic> body = {'email': email, 'password': password};
      String jsonBody = json.encode(body);
      final headers = {'Content-Type': 'application/json'};
      final encoding = Encoding.getByName('utf-8');
      var response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      print("tag.yes ${json.decode(response.body)}");
      if (response.statusCode != 401) {
        final Map<String, dynamic> parsed = json.decode(response.body);
        String token = parsed['token'];
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('auth-token', token);
        Provider.of<UserProvider>(context, listen: false).setUser(parsed);
        try {
          SharedPreferences.setMockInitialValues({});
          String? check = pref.getString('auth-token');
          print(check);
        } catch (e) {
          print(e);
        }
        Get.to(() => Home());
        return token;
      } else {
        print("tags.inerror");
        final Map parsed = json.decode(response.body);
        String error = parsed['error'];
        return error;
      }
    } catch (error) {
      return error;
    }
  }

  signupinfo(
      String name, String email, String password, String retypePassword) async {
    try {
      final uri = Uri.parse('$uristring/user/signup');
      Map<String, dynamic> body = {
        'name': name,
        'password': password,
        'retype': retypePassword,
        'email': email
      };
      String jsonBody = json.encode(body);
      final headers = {'Content-Type': 'application/json'};
      final encoding = Encoding.getByName('utf-8');
      var response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      print("Signup!!!");
      print(response.body);
      if (response.statusCode == 200) {
        Get.to(() => Home());
        return "Successful Signup!!";
      }
    } catch (error) {
      return "Please Fill All Fields !!";
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await get(Uri.parse('$uristring/products'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      print(body);
      List<ProductModel> value = <ProductModel>[];
      body.forEach((element) {
        value.add(ProductModel.fromJson(element));
      });
      return value;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Review>> getAllReviewsById(String id) async {
    final response = await get(Uri.parse('$uristring/products/getReviews/$id'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Review> value = <Review>[];
      body.forEach((element) {
        value.add(Review.fromJson(element));
      });

      return value;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> addReview(String title, String content, double rating,
      String id, String date) async {
    String body = jsonEncode({
      'reviews': {
        'review_title': title,
        'review_rating': rating,
        'review_content': content,
        'review_date': date
      }
    });

    final uri = Uri.parse('$uristring/products/addReview/$id');

    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    final response = await put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    print("tags.response ${response.body}");
    return response;
  }

  Future<List<ProductModel>> getSubCategoryProducts(String subcategory) async {
    if (subcategory.contains('&')) {
      subcategory = subcategory.replaceFirstMapped("&", (match) => "%26");
    }

    final response = await get(Uri.parse(
        '$uristring/products/subcategoryProducts?subcategory=$subcategory'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ProductModel> value = <ProductModel>[];
      body.forEach((element) {
        value.add(ProductModel.fromJson(element));
      });
      return value;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<String>> getSubCategroryList(String category) async {
    final response = await get(
        Uri.parse('$uristring/products/subcategory?category=$category'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final List<String> strs = body.map((e) => e.toString()).toList();

      return strs;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ProductModel>> getCategoryProducts(String category) async {
    final response =
        await get(Uri.parse('$uristring/products/category?category=$category'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ProductModel> value = <ProductModel>[];
      body.forEach((element) {
        value.add(ProductModel.fromJson(element));
      });
      print(value);
      return value;
    } else {
      throw Exception('Failed to load album');
    }
  }

  getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('auth-token');
      if (token.isEmptyOrNull) {
        pref.setString('auth-token', '');
      }
      final uri = Uri.parse('$uristring/user/tokencheck');
      final headers = {
        'Content-Type': 'application/json',
        'auth-token': token!,
        'Authorization': 'Bearer $token'
      };
      final encoding = Encoding.getByName('utf-8');
      var tokenRes = await post(
        uri,
        headers: headers,
        encoding: encoding,
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        print("here in api");
        var userRes = await get(Uri.parse('$uristring/user'), headers: headers);
        final Map<String, dynamic> parsed = json.decode(userRes.body);
        Provider.of<UserProvider>(context, listen: false).setUser(parsed);
      }
    } catch (e) {
      return "Error";
    }
  }
}
