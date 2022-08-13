import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class StaffAssignWorkSchedule {
  void addSchedule(context, token, list) async {
    String error = '';
    int count = 0;
    for (var element in list) {
      final response = await http.post(
        Uri.parse(
            'http://computer-services-api.herokuapp.com/schedule/assignslot'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $token',
        },
        body: jsonEncode({
          'date': element.date,
          'slot': element.slot,
          'start': element.start,
          'end': element.end,
        }),
      );
      if (response.statusCode == 200) {
      } else if (response.statusCode == 500) {
        count++;
        error += 'Slot ${element.slot} ngày ${element.date}: ${response.body}\n';
      } else {
        count = -1;
      }
    }
    if(count == -1){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        title: 'Hết phiên đăng nhập',
        desc: 'Vui lòng đăng nhập lại',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          AuthService().logOut(context);
        },
      ).show();
    }else
    if (count == 0) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Đăng ký lịch thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const StaffRegistWork()
          ));
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        title: 'Đăng kí lịch gặp vấn đề',
        desc: 'Vui lòng đăng ký lại',
        body: Center(child: SingleChildScrollView(
          child: Text(error),
        ),),
        dismissOnTouchOutside: false,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
