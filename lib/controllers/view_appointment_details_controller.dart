import 'package:computer_service_system/models/object/staff_get_booking_object.dart';
import 'package:computer_service_system/screens/staff_screens/create_order_page.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ViewAppointmentDetailsControllers extends FxController {
  List<Booking>? bookings;
  late Booking selectedAppointment;

  void goToSingleAppointment(Booking booking) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => StaffCreateOrderPage(booked: booking),
      ),
    );
  }

  @override
  String getTag() {
    return "view_appointment_details_controller";
  }
}
