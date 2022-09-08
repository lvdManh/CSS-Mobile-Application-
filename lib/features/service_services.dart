import 'dart:convert';
import 'package:computer_service_system/models/services_data.dart';
import 'package:http/http.dart' as http;

class ServiceServices{
  Future<List<Service>> fetchServices(token
      ) async{
    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/service/all-service'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<Service>((json) => Service.fromJson(json)).toList();
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }

}