import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/features/user_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/color_constant.dart';
import '../../models/user.dart';
import 'custom_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Account account;
  final String token;
  const UpdateProfileScreen({Key? key, required this.account, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _submitKey = GlobalKey<FormState>();
  UserServices updateProfile = UserServices();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController ward = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController phonenum = TextEditingController();
  final TextEditingController birth = TextEditingController();

  String parseDate(time){
    DateTime dt1 = DateTime.parse(time);
    return '${dt1.day}/${dt1.month}/${dt1.year}';
  }
  String revertDate(date){
    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(date);
    return inputDate.toString();
  }
  @override
  void initState() {
    super.initState();
    name.text = widget.account.name!;
    email.text = widget.account.email!;
    street.text = widget.account.address!.street!;
    ward.text = widget.account.address!.ward!;
    district.text = widget.account.address!.district!;
    city.text = widget.account.address!.city!;
    phonenum.text = widget.account.phonenum!;
    birth.text = parseDate(widget.account.birth!);
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
            "Cập nhật thông tin cá nhân",
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
                          const InputDecoration(labelText: 'Tên:'),
                          controller: name,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Email:'),
                          controller: email,
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
                          decoration: const InputDecoration(labelText: 'Phường/khu phố:'),
                          controller: ward,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Số nhà/đường:'),
                          controller: street,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Số điện thoại liên lạc:'),
                          controller: phonenum,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Ngày sinh:'),
                          controller: birth,
                        ),
                        const SizedBox(height: 8),
                        CustomButton(
                          text: 'Cập nhật',
                          onTap: () async {
                            if (_submitKey.currentState!.validate()) {
                                AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                dismissOnTouchOutside: false,
                                title: 'Lưu thông tin?',
                                btnCancelOnPress: (){},
                                btnOkOnPress: () {
                                  updateProfile.changeProfile(
                                      context: context,
                                      accessToken: widget.token,
                                      name: name.text,
                                      email: email.text,
                                      city: city.text,
                                      district: district.text,
                                      ward: ward.text,
                                      street: street.text,
                                      phone: phonenum.text,
                                      birth: revertDate(birth.text));
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