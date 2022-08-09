import 'dart:convert';
import 'package:computer_service_system/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductRequest {
  static const String url =
      "https://computer-services-api.herokuapp.com/accessory/all-accessories";
  static List<Accessory> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Accessory> products =
        list.map((model) => Accessory.fromJson(model)).toList();
    return products;
  }

  static Future<List<Accessory>> fetchPosts(token) async {
    final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get accessory list');
    }
  }
}
