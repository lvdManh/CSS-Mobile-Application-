import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:computer_service_system/models/order_data.dart';

class OrderServices{
  Future<Order> getOrderByIdForCus(token,id
      ) async{
    try {
      http.Response userRes = await http.get(
        Uri.parse('https://computer-services-api.herokuapp.com/order/cus/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $token',
        },
      );
      if(userRes.statusCode ==200){
        final parsed = Order.fromJson(jsonDecode(userRes.body.toString()));
        print(userRes.body);
        return  parsed;
      }
      else{
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e){
      throw Exception(e);
    }
  }
}