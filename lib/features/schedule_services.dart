import 'dart:convert';

import 'package:computer_service_system/models/schedule_data.dart';
import 'package:http/http.dart' as http;
class ScheduleServices{
  Future<List<Schedule>> fetchSevenDaySlot(
      ) async{
    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/schedule/oneweekschedule'),
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<Schedule>((json) => Schedule.fromJson(json)).toList();
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
}