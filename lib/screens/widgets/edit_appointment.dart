
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/screens/widgets/appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/color_constant.dart';
import '../../features/booking_services.dart';
import '../../models/booking_data.dart';
import 'custom_button.dart';

class EditAppointment extends StatefulWidget {
  final Bookings bookings;

  const EditAppointment({Key? key,required this.bookings}) : super(key: key);

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {

  final _submitKey = GlobalKey<FormState>();
  final BookingServices bookingServices = BookingServices();
  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController ward = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController services = TextEditingController();
  final TextEditingController time = TextEditingController();
  Bookings? newDetail;

  Future<Bookings?> getBookingById(id) async{

    final response = await http.get(
      Uri.parse(
          'https://computer-services-api.herokuapp.com/booking/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    if(response.statusCode==200) {
      final data = jsonDecode(response.body.toString());
      newDetail = Bookings.fromJson(data);
      return newDetail;
    }

    return newDetail;

  }
  @override
  void initState() {
    super.initState();
    username.text = widget.bookings.cusName!;
    phone.text = widget.bookings.phonenum!;
    street.text = widget.bookings.cusAddress!.street!;
    ward.text = widget.bookings.cusAddress!.ward!;
    district.text = widget.bookings.cusAddress!.district!;
    city.text = widget.bookings.cusAddress!.city!;
    type.text = widget.bookings.type!;
    services.text = widget.bookings.services.toString();
    time.text = widget.bookings.time!;
    description.text = widget.bookings.description!;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Cập nhật lịch hẹn",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: mBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _submitKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Tên người hẹn:'),
                          controller: username,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Số điện thoại:'),
                          controller: phone,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Thành phố:'),
                          controller: city,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Quận:'),
                          controller: district,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Phường:'),
                          controller: ward,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Số nhà:'),
                          controller: street,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Dịch vụ:'),
                          controller: services,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Loại máy:'),
                          controller: type,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Thời gian hẹn:'),
                          controller: time,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Mô tả vấn đề:'),
                          controller: description,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Cập nhật',
                          onTap: () async {
                            if (_submitKey.currentState!.validate()) {
                              bookingServices.editBooking(
                                  widget.bookings.id,
                                  street.text,
                                  ward.text,
                                  district.text,
                                  city.text,
                                  username.text,
                                  phone.text,
                                  services.text,
                                  description.text,
                                  type.text,
                                  time.text);

                              await getBookingById(widget.bookings.id);

                              await AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.SUCCES,
                                dismissOnTouchOutside: false,
                                title: 'Cập nhật lịch hẹn thành công',
                                desc: 'Chờ cửa hàng xác nhận lịch hẹn',
                                btnOkOnPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          AppointmentDetail(bookings: newDetail!)));
                                },
                              ).show();

                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
