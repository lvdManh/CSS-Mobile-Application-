import 'package:computer_service_system/models/object/staff_get_booking_object.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ViewAppointmentPageControllers extends FxController {
  List<Booking>? bookings;
  late Booking selectedAppointment;

  void goToSingleAppointment(Booking booking) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => StaffViewAppointmentDetailsPage(booking: booking),
      ),
    );
  }

  @override
  String getTag() {
    return "view_appointment_page_controller";
  }
}
