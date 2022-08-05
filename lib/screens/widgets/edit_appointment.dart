
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/color_constant.dart';
import '../../features/booking_services.dart';
import '../../features/service_services.dart';
import '../../models/booking_data.dart';
import '../../models/services_data.dart';
import 'custom_button.dart';
import 'multi_select_widget.dart';

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
  late List<Service> futureService;
  late List<String> serviceName = [];
  List<String> _selectedItems = [];
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

  Future<void> getNameService() async {
    futureService = await ServiceServices().fetchServices();

    for(int i =0; i < futureService.length;i++){
      serviceName.add(futureService[i].name.toString());
    }
  }

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: serviceName, title: "dịch vụ",);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
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
    services.text = widget.bookings.services!.join(', ').toString();
    time.text = widget.bookings.time!;
    description.text = widget.bookings.description!;
    getNameService();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text("Dịch vụ:",
                                    style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: _showMultiSelect,
                                      child: const Text('Chọn dịch vụ'),
                                    ),
                                  ],
                                ),
                                // display selected items
                              ],
                            ),
                            Column(

                              children: [
                                Wrap(
                                  children: _selectedItems
                                      .map((e) => Chip(
                                    label: Text(e),
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        ),
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

                              await getBookingById(widget.bookings.id);

                               AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                dismissOnTouchOutside: false,
                                title: 'Lưu thay đổi?',
                                btnCancelOnPress: (){},
                                btnOkOnPress: () {
                                  bookingServices.editBooking(context,
                                      widget.bookings.id,
                                      street.text,
                                      ward.text,
                                      district.text,
                                      city.text,
                                      username.text,
                                      phone.text,
                                      _selectedItems,
                                      description.text,
                                      type.text,
                                      time.text);
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
