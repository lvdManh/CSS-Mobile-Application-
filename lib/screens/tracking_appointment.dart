import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/auth_services.dart';
import 'package:computer_service_system/models/booking_object.dart';
import 'package:computer_service_system/screens/widgets/appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/booking_data.dart';
import '../providers/data_class.dart';

class TrackingAppointment extends StatefulWidget {
  const TrackingAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrackingAppointmentState();
}

class _TrackingAppointmentState extends State<TrackingAppointment> {
  List<Booking> bookingList = [];
   Bookings? bookings;
  Future<List<Booking>> getBookingListApi() async {
    final user = context.watch<DataClass>().user;
    bookingList.clear();
    final response = await http.get(
      Uri.parse(
          "https://computer-services-api.herokuapp.com/booking/all/bookings-account"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer ${user.accessToken}',
      },
    );
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
        bookingList.clear();
        for (Map i in data) {
          bookingList.add(Booking.fromJson(i));
        }
        return bookingList;
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        title: 'Hết phiên đăng nhập',
        desc: 'Vui lòng đăng nhập lại',
        btnOkOnPress: () { AuthService().logOut(context);},
      ).show();
      return bookingList;
    }
  }
  Future<Bookings?> getBookingById(id) async {

    final response = await http.get(
      Uri.parse(
          "https://computer-services-api.herokuapp.com/booking/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      print(bookings?.cusName.toString());
      bookings =  Bookings.fromJson(data);
      return bookings;
    }else{
      return bookings;
    }
  }


  @override
  Widget build(BuildContext context) {
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
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
                future: getBookingListApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return bookingList.isNotEmpty ? ListView.builder(
                        itemCount: bookingList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('Dịch vụ: ${bookingList[index]
                                  .services?.first}'),
                              subtitle:
                                  Text('Thời gian: ${bookingList[index].time.toString()}'),
                              trailing:
                                  Text(bookingList[index].status.toString()),
                              onTap: () async {
                                await getBookingById(bookingList[index].id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AppointmentDetail(
                                              bookings: bookings!,
                                            )));
                              },
                            ),
                          );
                        }) : const Center(child: Text('Chưa có lịch hẹn', style: TextStyle(fontSize: 18),),);
                  }
                })),
      ),
    );
  }
}