import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/models/order_detail_data.dart';
import 'package:computer_service_system/models/order_info_data.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/OrderCus.dart';
import 'auth_services.dart';

class OrderServices{
  //Lấy ra 1 order bằng booking id của customer
  Future<OrderCus> getOrderByIdForCus(token,id
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
        final parsed = OrderCus.fromJson(jsonDecode(userRes.body.toString()));
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
  Future<List<OrderStaff>> getOrderListForStaff(token,context
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
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          title: 'Hết phiên đăng nhập',
          desc: 'Vui lòng đăng nhập lại',
          dismissOnTouchOutside: false,
          btnOkOnPress: () { AuthService().logOut(context);},
        ).show();
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e){
      throw Exception(e);
    }
  }

   Future addDetailOrder(context, token,id,OrderDetails data)  async {
    final response = await http.post(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/order/add-detail-order/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      body: json.encode(
        data.toJson(),
      ),
    );
    if(response.statusCode == 200){
      computeMoney(token, id);
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Lưu thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.pop(context);
        }
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Lưu thất bại',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
  }

  Future<OrderInfo> getOrderInfoById(token,id) async{
    final response = await http.get(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/order-with-detail/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if(response.statusCode ==200){
      final parsed = OrderInfo.fromJson(json.decode(response.body));
      return  parsed;
    }else{
      throw('Dữ liệu lỗi');
    }

  }

  void acceptServiceByCus(context, token,id) async{
    final response = await http.patch(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/customer-confirm/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      // body: jsonEncode({
      //   'id' : id,
      // }),
    );
    if(response.statusCode ==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Xác nhận thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        title: 'Không thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }

  }
  void completeOderByStaff(context, token,id) async{
    final response = await http.patch(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/complete-order/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      // body: jsonEncode({
      //   'id' : id,
      // }),
    );
    if(response.statusCode ==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Đã hoàn thành',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        title: 'Không thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
  }
  void cancelOrderByStaff(context, token,id) async{
    final response = await http.patch(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/cancel-order/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      // body: jsonEncode({
      //   'id' : id,
      // }),
    );
    if(response.statusCode ==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Đã hủy lịch hẹn',
        desc: response.body,
        btnOkOnPress: () {
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Không thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }

  }
  void computeMoney(token,id) async{
    await http.get(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/get-order-total-price/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
  }

  Future addComputerToOrder(context, token,id, nameCom, codeCom, typeCom, brandCom)  async {
    final response = await http.patch(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/order/computer-to-order/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      body: json.encode(
          {
            'name': nameCom,
            'code': codeCom,
            'type': typeCom,
            'brand': brandCom
          }
      ),
    );
    if(response.statusCode == 200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Lưu thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Lưu thất bại',
        desc: response.statusCode.toString() + response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
  }

  Future<List<OrderStaff>> getHistoryOrderListForStaff(token,context
      ) async{
    try {
      http.Response response = await http.get(
        Uri.parse('https://computer-services-api.herokuapp.com/order/show/history-order-staff'),
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
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          title: 'Hết phiên đăng nhập',
          desc: 'Vui lòng đăng nhập lại',
          dismissOnTouchOutside: false,
          btnOkOnPress: () { AuthService().logOut(context);},
        ).show();
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e){

      throw Exception(e);
    }
  }

  void sendBusyOrder(context, token,id) async{
    final response = await http.patch(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/schedule/staff-in-work/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if(response.statusCode ==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.pushReplacementNamed(context, StaffViewAppointmentPage.routeName);
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        title: 'Không thành công',
        desc: response.body,
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
  }

  Future removeOrderDetail(context, token,id, orderId) async{
    final response = await http.post(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/order/removed-detail-order/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );
    if(response.statusCode ==200){
      computeMoney(token, orderId);
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Thành công',
        desc: response.body,
        btnOkOnPress: () {
        },
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        title: 'Không thành công',
        desc: response.body,
        btnOkOnPress: () {
        },
      ).show();
    }
  }
}