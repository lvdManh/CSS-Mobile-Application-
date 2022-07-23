import 'dart:convert';

import 'package:http/http.dart' as http;
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


}