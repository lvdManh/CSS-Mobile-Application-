import 'dart:convert';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:http/http.dart' as http;
import 'package:computer_service_system/models/order_data.dart';

class OrderServices{
  //Lấy ra 1 order bằng booking id của customer
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
        return  parsed;
      }
      else{
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e){
      throw Exception(e);
    }
  }

  // lấy ra danh sách order của staff
  Future<List<OrderStaff>> getOrderListForStaff(token
      ) async{
    try {
      http.Response response = await http.get(
        Uri.parse('https://computer-services-api.herokuapp.com/order/show/order-staff'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $token',
        },
      );
      if(response.statusCode ==200){
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return  parsed.map<OrderStaff>((json) => OrderStaff.fromJson(json)).toList();
      }
      else{
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e){
      throw Exception(e);
    }
  }

}