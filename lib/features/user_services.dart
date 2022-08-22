import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/screens/widgets/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/utils.dart';
import '../models/user.dart';
class UserServices{
  Future<Account> getUserData( accessToken
      ) async {
    try {
        http.Response userRes = await http.get(
          Uri.parse('https://computer-services-api.herokuapp.com/account/view-profile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': 'bearer $accessToken',
          },
        );
          if(userRes.statusCode ==200){
            final parsed = Account.fromJson(jsonDecode(userRes.body.toString()));
            return  parsed;
          }
          else{
            throw Exception('Lấy dữ liệu thất bại');
          }
    } catch (e){
      throw Exception(e);
    }
  }

  void changePassword({
    required context,
    required accessToken,
    required String oldPass,
    required String repeatPass,
    required String newPass,
  }) async{

      http.Response res = await http.patch(
        Uri.parse('https://computer-services-api.herokuapp.com/account/change-password'),
        body: jsonEncode({
          'oldpass' : oldPass,
          'repeatpass' : repeatPass,
          'newpass' : newPass,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.SUCCES,
            dismissOnTouchOutside: false,
            title: 'Đổi mật khẩu thàng công',
            btnOkOnPress: () {
                Navigator.pop(context);
            }
        ).show();
      }else if(res.statusCode==404){
        showSnackBar(context, 'Sai mật khẩu');
      }else{
        showSnackBar(context, 'Lỗi server');
      }


  }

  void changeProfile({
    required context,
    required accessToken,
    required name,
    required email,
    required city,
    required district,
    required ward,
    required street,
    required phone,
    required birth
  }) async{
    try {

      http.Response res = await http.patch(
        Uri.parse('https://computer-services-api.herokuapp.com/account/editprofile'),
        body: jsonEncode({
            'name' : name,
            'email' : email,
            'address' : {
                  'city': city,
                  'district': district,
                  'ward' : ward,
                  'street' : street,
                        },
            'phonenum': phone,
            'birth': birth
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': 'bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.SUCCES,
            dismissOnTouchOutside: false,
            title: 'Cập nhật thàng công',
            btnOkOnPress: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => const AccountScreen()
              )
              );
            }
        ).show();
      }else{
        showSnackBar(context, res.body);
      }

    } catch (e){
      showSnackBar(context, e.toString());
    }
  }
}