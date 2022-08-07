// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:computer_service_system/screens/staff_screens/staff_home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/error_handling.dart';
import '../constants/utils.dart';
import '../screens/auth_screen.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://computer-services-api.herokuapp.com/auth/register'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Tạo tài khoản thành công!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://computer-services-api.herokuapp.com/auth/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<DataClass>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'accessToken', jsonDecode(res.body)['accessToken']);
            Navigator.pushNamedAndRemoveUntil(
                context,
                Provider.of<DataClass>(context, listen: false).user.role ==
                        'customer'
                    ? NavScreen.routeName
                    : StaffHomePage.routeName, //thay staff cho nay
                (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        prefs.setString('accessToken', '');
      }
      var tokenRes = await http.post(
          Uri.parse('https://computer-services-api.herokuapp.com/auth/refresh'),
          headers: <String, String>{
            'Context-Type': 'application/json; charset=UTF-8',
            'token': accessToken!
          });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse(
              'https://computer-services-api.herokuapp.com/account/${prefs.getString('username')}'),
        );

        var userProvider = Provider.of<DataClass>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', '');
      await http.post(
        Uri.parse('https://computer-services-api.herokuapp.com/auth/logout'),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
