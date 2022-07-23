
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:computer_service_system/screens/widgets/edit_appointment.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';
import '../../models/booking_data.dart';

class AppointmentDetail extends StatelessWidget {
  final Bookings bookings;
  const AppointmentDetail({Key? key, required this.bookings}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.parse(bookings.time.toString());
    // String weekday = DateFormat('EEEE').format(dt1);
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Lịch hẹn",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: SingleChildScrollView(

            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              const SizedBox(height: 16),
              const Text("Thông tin người hẹn",
                  style: TextStyle(
                      color: mTextColorSecondary,
                      fontSize: 16,
                      fontFamily: 'Regular')),
                  const SizedBox(height: 8),
                  Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Tên",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(bookings.cusName.toString(),
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  //const Divider()
                ],
              ),
                  const SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Số điện thoại",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(bookings.phonenum.toString(),
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                ],
              ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Địa chỉ",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text('${bookings.cusAddress!.street.toString()}, ${bookings.cusAddress!.ward.toString()}, ${bookings.cusAddress!.district.toString()}',
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("Thông tin lịch hẹn",
                      style: TextStyle(
                          color: mTextColorSecondary,
                          fontSize: 16,
                          fontFamily: 'Regular')),
                  const SizedBox(height: 8),

                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Loại dịch vụ",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text(bookings.type.toString(),
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      //const Divider()
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Dịch vụ yêu cầu",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text(bookings.services.toString(),
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      //const Divider()
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Thời gian hẹn",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text('${dt1.hour}:${dt1.minute}, ${dt1.day}/${dt1.month}/${dt1.year}',
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      //const Divider()
                    ],

                  ),

                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text("Mô tả tình trạng:",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  Text(
                    bookings.description.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16.0),
                    maxLines: 2,),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Trạng thái lịch hẹn",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text(bookings.status.toString(),
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    text: 'Hủy lịch hẹn',
                                    onTap: (){
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    text: 'Thay đổi lịch hẹn',
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditAppointment(
                                                bookings: bookings,
                                              )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),





                ],
                ),

          ),
        )

    );
  }
}
