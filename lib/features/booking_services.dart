import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/models/booking_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/booking_data.dart';
import '../screens/customer_screens/nav_screen.dart';

class BookingServices{

  Future createBooking(
      context, token, street, ward, district, city, name, phonenum, services, description, time
      ) async{
    final response = await http.post(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      body: jsonEncode({
        'cus_address': {
          'city': city,
          'district': district,
          'ward': ward,
          'street': street
        },
        'cus_name': name,
        'type': 'Sửa tại nhà',
        'phonenum': phonenum,
        'services': services,
        'description': description,
        'time': time,
      }),
    );
    if(response.statusCode==200){
      AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.SUCCES,
          title: 'Đặt lịch hẹn thành công',
          desc: 'Vui lòng chờ quản lí xác nhận lịch hẹn',
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              NavScreen.routeName,
                  (route) => false,
            );
      },
      ).show();
    }else{
      AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          title: 'Đặt lịch không thành công',
          desc: 'Vui lòng điền đầy đủ thông tin',
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
      },
      ).show();
    }
  }

  Future<List<Booking>> fetchBooking(token
      ) async{
    final response = await http.get(
      Uri.parse(
          "https://computer-services-api.herokuapp.com/booking/all/bookings-account"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<Booking>((json) => Booking.fromJson(json)).toList();
    }else{
      // AwesomeDialog(
      //   context: context,
      //   animType: AnimType.SCALE,
      //   dialogType: DialogType.WARNING,
      //   title: 'Hết phiên đăng nhập',
      //   desc: 'Vui lòng đăng nhập lại',
      //   dismissOnTouchOutside: false,
      //   btnOkOnPress: () { AuthService().logOut(context);},
      // ).show();
      throw Exception('Lấy dữ liệu thất bại');
    }

  }

  Future<Bookings> getOneBookingById(token,id
      ) async{
    final response = await http.get(
      Uri.parse(
          "https://computer-services-api.herokuapp.com/booking/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
    );

    if(response.statusCode == 200){
      final parsed = Bookings.fromJson(jsonDecode(response.body.toString()));
      return  parsed;
    }else{
      // AwesomeDialog(
      //   context: context,
      //   animType: AnimType.SCALE,
      //   dialogType: DialogType.WARNING,
      //   title: 'Hết phiên đăng nhập',
      //   desc: 'Vui lòng đăng nhập lại',
      //   dismissOnTouchOutside: false,
      //   btnOkOnPress: () { AuthService().logOut(context);},
      // ).show();
      throw Exception('Lấy dữ liệu thất bại');
    }

  }

  Future editBooking(context,token,id,
      street, ward, district, name, phonenum, services, description
      ) async{
    String city = "HCM";
    final response = await http.put(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      body: jsonEncode({
        'cus_address': {
          'city': city,
          'district': district,
          'ward': ward,
          'street': street
        },
        'cus_name': name,
        'phonenum': phonenum,
        'services': services,
        'description': description
      }),
    );
    if(response.statusCode==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Cập nhật thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      ).show();

    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Thay đổi không thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
  }

  Future cancelBooking(context,id,token
      ) async{
    final response = await http.patch(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/cancel-booking/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      // body: jsonEncode({
      //   'id' : id
      // }),
    );
    if(response.statusCode==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Hủy lịch hèn thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();

    }else{
      throw("Lỗi");
    }
  }

}