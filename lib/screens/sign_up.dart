
import 'dart:async';

import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String resultText = "";
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  Future<int?> login(String phone, password) async{
    if (kDebugMode) {
      print(phone);
      print(password);
    }
    try{
      Response response = await post(Uri.parse('https://computer-services-api.herokuapp.com/auth/register'),
      body: {
        'username': phone,
        'password': password
      }
      );
      if(response.statusCode==200){
          if (kDebugMode) {
            print(response.body);
            resultText = "Thành công";
            return response.statusCode;
          }
      }else{
        if (kDebugMode) {
          print(response.body);

          return response.statusCode;
        }
        resultText = response.body;
      }

    }catch(e){
      if (kDebugMode) {
        print(e.toString());

      }
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Đăng ký tài khoản",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Số điện thoại',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Mật khẩu',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Nhập lại mật khẩu',
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
                onTap: () async {
                  // auth.register(phoneController.text, passwordController.text).then((response) {
                  //   if(response['status']){
                  //     User user = response['data'];
                  //     Provider.of<UserProvider>(context).setUser(user);
                  //     Navigator.pushReplacementNamed(context, '/login');
                  //   }else{
                  //     const snackBar = SnackBar(
                  //       content: Text('Đăng ký thất bại'),
                  //       duration: Duration(seconds: 5),
                  //     );
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   }
                  //
                  // });

                  if(confirmPasswordController.text.endsWith(passwordController.text)
                      &&confirmPasswordController.text.length == passwordController.text.length) {
                    int? code = await login(
                        phoneController.text, passwordController.text);
                    // showDialog(
                    //     context: context,
                    //
                    //     builder: (BuildContext context) {
                    //       return const Center(child: CircularProgressIndicator(),);
                    //     });
                    if (code == 200) {
                      const snackBar = SnackBar(
                        content: Text('Đăng ký thành công', textAlign: TextAlign
                            .center,),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavScreen()));
                    } else if(code == 500){
                      const snackBar = SnackBar(
                        content: Text('Số điện thoại đã được sử dụng', textAlign: TextAlign
                            .center,),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else {
                      const snackBar = SnackBar(
                        content: Text('Điền thông tin để đăng nhập', textAlign: TextAlign
                            .center,),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else{
                    const snackBar = SnackBar(
                      content: Text('Nhập lại mật khẩu', textAlign: TextAlign
                          .center,),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }



                },
              child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Đăng ký', style: TextStyle(fontSize: 18),),
              ),
            ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
