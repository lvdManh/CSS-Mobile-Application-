import 'dart:convert';
import 'package:computer_service_system/models/accessory_data.dart';
import 'package:http/http.dart' as http;

class ProductRequest {
  Future<List<Accessory>> fetchAccessory(token
      ) async{
    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/accessory/all-accessories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<Accessory>((json) => Accessory.fromJson(json)).toList();
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
}
