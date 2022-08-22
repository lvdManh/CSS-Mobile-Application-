import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../features/user_services.dart';
import 'account_button.dart';
import 'custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String token;
  const ChangePasswordScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final UserServices userService = UserServices();
  final _changePassKey = GlobalKey<FormState>();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  void changePass(accessToken) {
    AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.QUESTION,
        dismissOnTouchOutside: false,
        title: 'Xác nhận thay đổi?',
        btnCancelOnPress: (){},
        btnOkOnPress: () {
          userService.changePassword(
              context: context,
              accessToken: accessToken,
              oldPass: oldPassController.text,
              repeatPass: repeatPassController.text,
              newPass: newPassController.text);
        }
    ).show();
  }

  @override
  void initState(){
    super.initState();
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
            "Đổi mật khẩu",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(

        width: double.infinity,
        height: double.infinity,

        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),

        child: Center(
          child: Form(
            key: _changePassKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: oldPassController,
                  hintText: 'Mật khẩu cũ',
                  secure: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: repeatPassController,
                  hintText: 'Mật khẩu mới',
                  secure: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: newPassController,
                  hintText: 'Nhập lại mật khẩu mới',
                  secure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    AccountButton(
                      text: 'Đổi mật khẩu',
                      onTap: () => {
                        if(_changePassKey.currentState!.validate()){
                            if(oldPassController.text != newPassController.text){
                              FocusScope.of(context).requestFocus(FocusNode()),
                              changePass(widget.token)
                            }else{
                              showSnackBar(context, "Mật khẩu mới trùng mật khẩu cũ")
                            }
                            //changePass(user.accessToken),
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}
