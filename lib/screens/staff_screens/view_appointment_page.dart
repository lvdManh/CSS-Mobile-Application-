library flutx;

import 'package:computer_service_system/features/booking_services.dart';
import 'package:computer_service_system/models/object/staff_get_booking_object.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutx/flutx.dart';

class StaffViewAppointmentPage extends StatefulWidget {
  static const String routeName = '/view_appointment_page';
  const StaffViewAppointmentPage({Key? key}) : super(key: key);
  @override
  _StaffViewAppointmentPageState createState() =>
      _StaffViewAppointmentPageState();
}

class _StaffViewAppointmentPageState extends State<StaffViewAppointmentPage> {
  int _selectedItemIndex = 1;
  int currentPage = 1;
  late List<Booking>? listBooking = [];

  Future<bool> getBookingData() async {
    final Uri uri = Uri.parse(
        "http://computer-services-api.herokuapp.com/booking/all?sort=desc&status=accepted&page=1&limit=10");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = appointmentFromJson(response.body);
      listBooking = result.bookings;
      currentPage++;
      setState(() {});
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get booking list');
    }
  }

//'desc', 'accepted', 1, 10
  @override
  void initState() {
    super.initState();
    getBookingData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Computer Services",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text('Xem lịch hẹn',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ))),
        ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listBooking?.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          'Tên khách hàng: ${listBooking?[index].cusName}\nSố điện thoại: ${listBooking?[index].phonenum} \nĐịa chỉ: đường ${listBooking?[index].cusAddress?.ward},  ${listBooking?[index].cusAddress?.street}, ${listBooking?[index].cusAddress?.district}, ${listBooking?[index].cusAddress?.city}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StaffViewAppointmentDetailsPage(
                                      booking: listBooking?[index]),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          },
        )
      ]),
      // Bottom Navigation
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.list_alt, 1),
          buildNavBarItem(Icons.notifications, 2),
          buildNavBarItem(Icons.person, 3)
        ],
      ),
      // This is Background Color
    );
  }

  // Widget _buildBookingList() {
  //   List<Widget> list = [];

  //   list.add(FxSpacing.width(20));

  //   for (Booking booking in bookingData!) {
  //     list.add(FxContainer(
  //       onTap: () {
  //         controller.goToSingleAppointment(booking);
  //       },
  //       borderRadiusAll: 4,
  //       paddingAll: 16,
  //       margin: FxSpacing.nTop(20),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     FxText.bodyMedium(
  //                       'Tên khách hàng: ${booking.cusName} \n Triệu chứng: ${booking.description} \n Số điện thoại: ${booking.phonenum}',
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ));
  //   }
  //   return Column(
  //     children: list,
  //   );
  // }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}
