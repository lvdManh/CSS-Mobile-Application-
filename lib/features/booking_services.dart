import 'dart:convert';

import 'package:computer_service_system/models/booking_object.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class BookingServices{
  Future createBooking(
      token, street, ward, district, city, name, phonenum, services, description, type, time
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
        'phonenum': phonenum,
        'services': services,
        'description': description,
        'time': time,
        'type': type,
        'status': 'pending'
      }),
    );
    if(response.statusCode==200){
      print("Tạo thành công");
    }else{
      print(response.body);
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

  Future editBooking(id,
      street, ward, district, city, name, phonenum, services, description, type, time
      ) async{
    final response = await http.put(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
        'description': description,
        'time': time,
        'type': type,
      }),
    );
    if(response.statusCode==200){
      print("Cập nhật thành công");
    }else{
      print(response.body);
    }
  }

  Future cancelBooking(id
      ) async{
    final response = await http.patch(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/cancel-booking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id' : id
      }),
    );
    if(response.statusCode==200){
        print("Hủy thành công");

    }else{
      print("Lỗi");
    }
  }

}