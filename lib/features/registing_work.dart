import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffRegistingWorkService {
  Future createSchedule(context, token, date, slot, start, end) async {
    final response = await http.post(
      Uri.parse(
          'http://computer-services-api.herokuapp.com/schedule/assignslot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer $token',
      },
      body: jsonEncode({
        'date': date,
        'slot': slot,
        'start': start,
        'end': end,
      }),
    );
    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Đăng ký lịch làm việc thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NavScreen()));
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Đặt lịch làm việc không thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
