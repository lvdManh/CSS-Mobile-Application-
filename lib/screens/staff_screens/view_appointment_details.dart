import 'package:computer_service_system/models/object/staff_get_booking_object.dart';
import 'package:computer_service_system/screens/staff_screens/create_order_page.dart';
import 'package:flutter/material.dart';

class StaffViewAppointmentDetailsPage extends StatefulWidget {
  static const String routeName = '/view_appointment_details';
  @override
  _StaffViewAppointmentDetailsState createState() =>
      _StaffViewAppointmentDetailsState();

  final Booking? booking;

  const StaffViewAppointmentDetailsPage({super.key, required this.booking});
}

class _StaffViewAppointmentDetailsState
    extends State<StaffViewAppointmentDetailsPage> {
  int _selectedItemIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Computer Services",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      //--------------------Body------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text('Xem lịch hẹn',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ))),
          Container(
            width: 120,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Text(
              'Thời gian: ${widget.booking?.time} \n Địa chỉ: ${widget.booking?.cusAddress} \n SDT: ${widget.booking?.phonenum}',
            ),
          ),
          const Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('Thông tin khách hàng',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ))),
          Container(
            height: 200,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Text(
              'Khách hàng: ${widget.booking?.cusName} \nTình trạng máy: ${widget.booking?.description}',
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: const Text(
              "Tạo hóa đơn",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StaffCreateOrderPage(booked: widget.booking),
                ),
              );
            },
          ),
        ],
      ),
      // Bottom Navigation----------------
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
                border: const Border(
                  bottom:
                      const BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}
