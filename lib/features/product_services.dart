import 'dart:convert';
import 'package:computer_service_system/models/accessory_data.dart';
import 'package:http/http.dart' as http;

class ProductRequest {

  Future<AccessoryMix> fetchAccessorySort(token, sortPrice, isHot, sortTypeCom,name
      ) async{
    if(sortPrice == 'Lớn nhất'){
      sortPrice = 'desc';
    }else{
      sortPrice = 'asc';
    }
    if(sortTypeCom == 'Tất cả'){
      sortTypeCom = '';
    }
    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/accessory/all-accessories-for-customer?sort=$sortPrice&isHot=$isHot&limit=20&type=$sortTypeCom&name=$name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if(response.statusCode == 200){
      final parsed = AccessoryMix.fromJson(json.decode(response.body));
      return  parsed;
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
}
