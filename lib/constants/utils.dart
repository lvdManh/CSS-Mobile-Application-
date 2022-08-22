
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text,textAlign: TextAlign.center,),
    ),
  );
}

String parseDate(date){
  if(date == null){
    return '--:--\n--/--/----';
  }
  DateTime dt1 = DateTime.parse(date);
  DateTime dt2 = dt1.add(const Duration(hours: 7));
  String hour = dt2.hour.toString();
  String minute = dt2.minute.toString();
  if(dt2.hour<10){
    hour = '0$hour';
  }
  if(dt2.minute<10){
    minute = '0$minute';
  }
  return '$hour:$minute, ${dt2.day}/${dt2.month}/${dt2.year}';
}

String parseDateNoUTC(date){
  if(date == null){
    return '--:--\n--/--/----';
  }
  DateTime dt1 = DateTime.parse(date);
  String hour = dt1.hour.toString();
  String minute = dt1.minute.toString();
  if(dt1.hour<10){
    hour = '0$hour';
  }
  if(dt1.minute<10){
    minute = '0$minute';
  }
  return '$hour:$minute, ${dt1.day}/${dt1.month}/${dt1.year}';
}



String parseDateDownLine(date){
  if(date == null){
    return '--:--\ndd/MM';
  }
  DateTime dt1 = DateTime.parse(date);
  DateTime dt2 = dt1.add(const Duration(hours: 7));
  String hour = dt2.hour.toString();
  String minute = dt2.minute.toString();
  if(dt2.hour<10){
    hour = '0$hour';
  }
  if(dt2.minute<10){
    minute = '0$minute';
  }
  return '$hour:$minute\n${dt2.day}/${dt2.month}';
}

String convertMoney(int? price) {
  String converted = price.toString().replaceAllMapped(
      RegExp(r"(?<=\d)(?=(\d\d\d)+(?!\d))"), (match) => "${match.group(0)}.");
  return converted;
}

String printAddress(street, ward, district) {
  if(street == null || ward == null || district == null){
    return '';
  }
  return '$street, $ward, $district';
}

int convertTimeToInt(String hour,String minute){
  return int.parse(hour+minute);
}

Color getStatusColor(String? status){
  if(status == 'Đang xử lí') {
    return Colors.orange;
  }else if(status == 'Hủy'){
    return Colors.red;
  }else if(status == 'Đã tiếp nhận'){
    return Colors.green.shade700;
  }else{
    return Colors.black;
  }
}

