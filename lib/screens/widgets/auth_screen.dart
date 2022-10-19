import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/auth_services.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:computer_service_system/screens/widgets/custom_text_field.dart';
//import 'package:computer_service_system/screens/widgets/otp_vertify_screen.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String resultText = "";
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }


  void signUpUser() {
    authService.signUpUser(
      context: context,
      username: phoneController.text,
      password: passwordController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      username: phoneController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [Image.asset('assets/images/launch_image.png',color: mBackgroundColor.withOpacity(0.8), colorBlendMode: BlendMode.modulate,)]),
                ListTile(
                  tileColor: _auth == Auth.signin ? mBackgroundColor : mGreyColor,
                  title: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: mSecondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: mBackgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: phoneController,
                            hintText: 'Số điện thoại',
                            secure: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Mật khẩu',
                            secure: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'Đăng nhập',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signup ? mBackgroundColor : mGreyColor,
                  title: const Text(
                    'Tạo tài khoản',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: mSecondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: mBackgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: phoneController,
                            hintText: 'Số điện thoại',
                            secure: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Mật khẩu',
                            secure: true,
                          ),

                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Đăng ký tài khoản',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                                //Navigator.of(context).push(MaterialPageRoute(
                                    //builder: (context) => OTPScreen(phone: phoneController.text, password: passwordController.text,)));
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
