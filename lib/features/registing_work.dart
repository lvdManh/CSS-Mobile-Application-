import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class StaffAssignWorkSchedule {
  Future addSchedule(context, token, datas) async {

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


      if (response.statusCode == 401) {
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
        }else if(response.statusCode ==200 || response.statusCode ==503){
        final parsed = json.decode(response.body.toString());
        List<HandleMessage>?  handleMes= [];
        String result = '';
        int count =0;
        for (Map i in parsed) {
          handleMes.add(HandleMessage.fromJson(i));
          if(handleMes[count].warning != null) {
            result += '\n${handleMes[count].warning}';
          }
          count++;
        }
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.SUCCES,
          title: 'Đăng ký lịch thành công',
          desc: result,
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(
                builder: (context) => const StaffRegistWork()
            ));
          },
        ).show();
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          title: 'Đăng ký lịch gặp vấn đền',
          desc: response.statusCode.toString(),
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
          },
        ).show();
      }
  }
}


class HandleMessage {
  String? warning;
  String? success;

  HandleMessage({this.warning, this.success});

  HandleMessage.fromJson(Map<dynamic, dynamic> json) {
    if(json["Warning"] is String) {
      warning = json["Warning"];
    }
    if(json["Success"] is String) {
      success = json["Success"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Warning"] = warning;
    data["Success"] = success;
    return data;
  }
}
