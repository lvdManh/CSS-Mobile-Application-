import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/color_constant.dart';
import '../../models/object/booking_object.dart';


class AppointmentDetail extends StatelessWidget {
  final Booking booking;
  const AppointmentDetail({Key? key, required this.booking}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.parse(booking.time.toString());
    String weekday = DateFormat('EEEE').format(dt1);
    return Scaffold(
        backgroundColor: mBackgroundColor,
        appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text("Lịch hẹn",
        style: TextStyle(
        fontSize: 23,
    ),
    ),
    centerTitle: true,
    ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Mã lịch hẹn: ${booking.id}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Người hẹn: ${booking.cusName}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Số điện thoại: ${booking.phonenum}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Dịch vụ: ${booking.type}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Loại dịch vụ: ${booking.services}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Mô tả: ${booking.description}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Địa chỉ: ${booking.cusAddress?.street}, ${booking.cusAddress?.ward}, ${booking.cusAddress?.district}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Thời gian hẹn: ${dt1.hour}:${dt1.minute}, $weekday ${dt1.day}/${dt1.month}/${dt1.year}',style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 10.0,
            ),
             Text('Trạng thái: ${booking.status}',style: TextStyle(fontSize: 16),),

          ],
        ),
      ),

    );
  }
}

