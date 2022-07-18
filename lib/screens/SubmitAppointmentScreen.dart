import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class SubmitAppointment extends StatefulWidget {
  const SubmitAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubmitAppointmentState();
}

class _SubmitAppointmentState extends State<SubmitAppointment> {
  late String _name;
  late String _phone;
  late String _address;
  late String _computerType;
  late String _computerDescription;
  late String _otherRequest;
  late String _time;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Tên:'),
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Số điện thoại:'),
      onSaved: (String? value) {
        _phone = value!;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Địa chỉ:'),
      onSaved: (String? value) {
        _address = value!;
      },
    );
  }

  Widget _buildComputerType() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nhãn hiệu thiết bị:'),
      onSaved: (String? value) {
        _computerType = value!;
      },
    );
  }

  Widget _buildComputerDescription() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Vấn đề của máy:'),
      onSaved: (String? value) {
        _computerDescription = value!;
      },
    );
  }

  Widget _buildOtherRequest() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Yêu cầu khác:'),
      onSaved: (String? value) {
        _otherRequest = value!;
      },
    );
  }

  Widget _buildTime() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Thời gian hẹn:'),
      initialValue: "8:00AM - 19/6/2022",
      onSaved: (String? value) {
        _time = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
        ),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildAddress(),
              _buildPhone(),
              _buildComputerType(),
              _buildComputerDescription(),
              _buildOtherRequest(),
              _buildTime(),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: const Text(
                    'Xác nhận đặt lịch',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () => {
                  AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.SUCCES,
                  title: 'Đặt lịch hẹn thành công',
                  desc:   'Chờ cửa hàng xác nhận lịch hẹn',
                  btnOkOnPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavScreen()));
                  },
                  )..show(),
                      },
                  )
            ],
          ),
        ),
      ),
    );
  }
}
