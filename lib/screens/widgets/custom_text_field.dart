import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool secure;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.secure,
    this.maxLines = 1,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: secure,
      decoration: InputDecoration(
          hintText: hintText,

          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              ),
          )),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Nhập $hintText';
        // }else if(hintText == 'Số điện thoại' &&
        //     !RegExp('^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})').hasMatch(val)) {
        //   return 'Số điện thoại không đúng định dạng';
        // }else if(hintText == 'Mật khẩu' && val.length < 8){
        //   return 'Mật khẩu phải từ 8 ký tự';
        }
          return null;
      },
      maxLines: maxLines,
    );
  }
}