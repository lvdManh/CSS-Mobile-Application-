
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/features/booking_services.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:computer_service_system/screens/widgets/edit_appointment.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';
import '../../models/booking_object.dart';


class AppointmentDetail extends StatelessWidget {
  final Booking bookings;
  const AppointmentDetail({Key? key, required this.bookings}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.parse(bookings.time.toString());
    // String weekday = DateFormat('EEEE').format(dt1);
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
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
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
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
                      const Text("Tên:",
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
                      const Text("Số điện thoại:",
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
                          const Text("Địa chỉ:   ",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),

                          Flexible(

                            child: Text('${bookings.cusAddress!.street.toString()}, ${bookings.cusAddress!.ward.toString()}, ${bookings.cusAddress!.district.toString()}',
                                style: const TextStyle(fontSize: 18, fontFamily: 'Regular'), textAlign: TextAlign.right,),
                          ),
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
                          const Text("Loại máy:",
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
                          const Text("Dịch vụ yêu cầu:",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Flexible(
                            child: Text(bookings.services!.join(', ').toString(),
                                style: const TextStyle(fontSize: 18, fontFamily: 'Regular'),textAlign: TextAlign.right,),
                          ),
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
                          const Text("Thời gian hẹn:",
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                    child: Text(
                      bookings.description.toString(),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18.0),
                      maxLines: 2,),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Trạng thái lịch hẹn:",
                              style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          Text(bookings.status.toString(),
                              style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (bookings.status=='pending') Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    text: 'Hủy lịch hẹn',
                                    onTap: (){
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.WARNING,
                                        headerAnimationLoop: false,
                                        closeIcon: const Icon(Icons.close_fullscreen_outlined),
                                        title: 'Xác nhận hủy?',
                                        desc:
                                        'Chắc chắn hủy lịch hẹn?',
                                        btnCancelOnPress: () {
                                        },
                                        onDissmissCallback: (type) {
                                        },
                                        btnOkOnPress: () {
                                          BookingServices().cancelBooking(bookings.id);
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.SUCCES,
                                            autoHide: const Duration(seconds: 2),
                                            headerAnimationLoop: false,
                                            closeIcon: const Icon(Icons.close_fullscreen_outlined),
                                            title: "Hủy thành công",
                                            btnOkOnPress: (){
                                              Navigator.popAndPushNamed(context, '/tracking-appointment');
                                            }
                                          ).show();
                                        },
                                      ).show();
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
                          ) else Align(
                    alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 150,
                          child: CustomButton(
                            text: 'Xem thêm',
                            onTap: (){
                            },
                          ),
                        ),

                  ),





                ],
                ),

          ),
        )

    );
  }
}
