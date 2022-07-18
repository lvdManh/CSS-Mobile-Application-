
import 'dart:convert';
import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/models/object/booking_object.dart';
import 'package:computer_service_system/screens/widgets/appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackingAppointment extends StatefulWidget {
  const TrackingAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrackingAppointmentState();
}

class _TrackingAppointmentState extends State<TrackingAppointment> {

  List<Booking> bookingList = [];

  Future<List<Booking>> getBookingApi () async {
    final response  = await http.get(Uri.parse("https://computer-services-api.herokuapp.com/booking/all"));
    var data = jsonDecode(response.body.toString());
    if( response.statusCode == 200 ){
      bookingList.clear();
      for(Map i in data){
        bookingList.add(Booking.fromJson(i));
      }
        return bookingList;
    } else{
      return bookingList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mBackgroundColor,
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

      body: Padding(
        padding: const EdgeInsets.all(10),
            child: FutureBuilder(
            future: getBookingApi(),
            builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                  child: CircularProgressIndicator()

              );
            }else{
                return ListView.builder(
                    itemCount: bookingList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              bookingList[index].services!.toList().first),
                          subtitle: Text(bookingList[index].time.toString()),
                          trailing: Text(bookingList[index].status.toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentDetail(
                                    booking: bookingList[index],
                                  )
                                  ));
                          },
                        ),
                      );
                    });
            }
          },
          )
      )
      );
  }
}