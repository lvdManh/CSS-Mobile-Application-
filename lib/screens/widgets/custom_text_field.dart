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
        }else if(hintText == 'Số điện thoại' &&
            !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val)) {
          return 'Số điện thoại không đúng định dạng';
        }else if(hintText == 'Mật khẩu' && val.length < 6){
          return 'Mật khẩu phải từ 6 ký tự';
        // }else{
        //   if(hintText = 'Số điện thoại'){
        //     return validateMobile(controller.text);
        //   }
        }else{
          return null;
        }
      },
      maxLines: maxLines,
    );
  }
}
String validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Hãy nhập số điện thoại';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Hãy nhập đúng định dạng số điện thoại';
  }
  return '';
}