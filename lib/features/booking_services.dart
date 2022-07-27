import 'dart:convert';

import 'package:computer_service_system/models/object/staff_get_booking_object.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BookingRequest {
  static const String url =
      "http://computer-services-api.herokuapp.com/booking/all";
  // static const String url =
  // "http://computer-services-api.herokuapp.com/booking/all?sort=desc&status=accepted&page=1&limit=10";
  // "http://computer-services-api.herokuapp.com/booking/all?$sort&$status&$page&$limit";

  static List<appointment> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<appointment> bookings =
        list.map((model) => appointment.fromJson(model)).toList();
    return bookings;
  }

//sort, status, page, limit
  static Future<List<appointment>> fetchBooking() async {
    final response = await http.get(
        // Uri.parse('$url?sort=$sort&status=$status&page=$page&limit=$limit'));
        Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get booking list');
    }
  }
}

// class API_Manager {
//   Future<appointment> getAppointments() async {
//     var client = http.Client();
//     var appointmentModel;
//     String appointment_url =
//         'http://computer-services-api.herokuapp.com/booking/all';
//     String basicAuth = 'Basic exampleauthkey';
//     try {
//       var response = await client.get(Uri.parse(appointment_url));
//       //print(response.statusCode);
//       //developer.log(response.body);
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);
//         appointmentModel = appointment.fromJson(jsonMap);
//       }
//     } catch (Exception) {
//       return appointmentModel;
//     }
//     return appointmentModel;
//   }

//   Future<appointment> getSingleContact(String id) async {
//     var client = http.Client();
//     var singleBookingModel;
//     String singleBookingUrl = 'https://example.com/api/contacts/id';
//     try {
//       var response = await client.get(Uri.parse(singleBookingUrl));
//       print(response.statusCode);
//       //developer.log(response.body);
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);
//         singleBookingModel = appointment.fromJson(jsonMap);
//       }
//     } catch (Exception) {
//       return singleBookingModel;
//     }
//     return singleBookingModel;
//   }
// }
