
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../features/booking_services.dart';
import '../../features/service_services.dart';
import '../../models/booking_object.dart';
import '../../models/services_data.dart';
import 'custom_button.dart';
import 'multi_select_widget.dart';

class EditAppointment extends StatefulWidget {
  final Booking bookings;

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
  late List<Service> futureService;
  late List<String> serviceName = [];
  List<String> _selectedItems = [];


  Future<void> getNameService(token) async {
    futureService = await ServiceServices().fetchServices(token);
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
    String userToken = Provider.of<DataClass>(context).user.accessToken;
    getNameService(userToken);
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
                          onTap: ()  {
                            if (_submitKey.currentState!.validate()) {
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
