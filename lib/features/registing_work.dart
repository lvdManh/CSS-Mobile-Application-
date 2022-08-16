import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/models/staff_register.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class StaffAssignWorkSchedule {
  void addSchedule(context, token, list) async {
      List<StaffRegister> slotList = [];
      slotList.addAll(list);
      print(slotList.length);
      ListScheduleRegister datas = ListScheduleRegister(datas: []);
      datas.datas = slotList;
      print(json.encode(datas.toJson()).toString());
      final response = await http.post(
        Uri.parse(
            'http://computer-services-api.herokuapp.com/schedule/assignslot'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $token',
        },
        body: json.encode(
          datas.toJson(),
        ),
      );
      print(response.statusCode );
      print(response.body);
      if (response.statusCode != 200) {
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
        }else {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.SUCCES,
          title: 'Đăng ký lịch thành công',
          desc: response.body,
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => const StaffRegistWork()
            ));
          },
        ).show();
      }
  }
}
