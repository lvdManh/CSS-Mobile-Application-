import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/booking_services.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import '../providers/data_class.dart';

class SubmitAppointment extends StatefulWidget {
  static const String routeName = '/submit-appointment';
  const SubmitAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubmitAppointmentState();
}

class _SubmitAppointmentState extends State<SubmitAppointment> {
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
  final TextEditingController status = TextEditingController();

  @override
  void initState() {
    final userProvider = Provider.of<DataClass>(context, listen: false);
    super.initState();
    phone.text = userProvider.user.username;
    // time.text = '22/7/2022';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<DataClass>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Sửa chữa tại nhà",
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
                  padding: const EdgeInsets.all(10),
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
                          text: 'Đặt lịch',
                          onTap: () {
                            if (_submitKey.currentState!.validate()) {
                              bookingServices.createBooking(
                                  userProvider.user.accessToken,
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
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.SUCCES,
                                title: 'Đặt lịch hẹn thành công',
                                desc: 'Vui lòng chờ quản lí xác nhận lịch hẹn',
                                dismissOnTouchOutside: false,
                                btnOkOnPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NavScreen()));
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
