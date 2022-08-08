import 'dart:convert';

import 'package:computer_service_system/models/slot_data.dart';
import 'package:http/http.dart' as http;

import '../models/work_schedule_data.dart';
class ScheduleServices{
  Future<List<Slot>> fetchSevenDaySlot(
      ) async{
    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/schedule/oneweekschedule'),
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<Slot>((json) => Slot.fromJson(json)).toList();
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
  Future<List<WorkSchedule>> fetchWorkSlotList() async{
    final response = await http.get(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/schedule/show-schedule-for-assign'),
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  parsed.map<WorkSchedule>((json) => WorkSchedule.fromJson(json)).toList();
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
}