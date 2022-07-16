
import 'dart:async';
import 'package:computer_service_system/screens/NavScreen.dart';
import 'package:computer_service_system/screens/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String resultText = "";
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  Future<int?> login(String phone, password) async{
    if (kDebugMode) {
      print(phone);
      print(password);
    }
    try{
      Response response = await post(Uri.parse('https://computer-services-api.herokuapp.com/auth/login'),
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
            "Đăng nhập",
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
                  hintText: 'Tài khoản',
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
                  int? loggedIn = await login(
                      phoneController.text, passwordController.text);
                  // showDialog(
                  //     context: context,
                  //
                  //     builder: (BuildContext context) {
                  //       return const Center(child: CircularProgressIndicator(),);
                  //     });
                  if (loggedIn == 200) {
                    const snackBar = SnackBar(
                      content: Text('Đăng nhập thành công', textAlign: TextAlign
                          .center,),
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavScreen()));
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Sai tài khoản hoặc mật khẩu', textAlign: TextAlign
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
                    child: Text('Đăng nhập', style: TextStyle(fontSize: 18),),
                  ),
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                child: const Text("Quên mật khẩu?",
                    style: TextStyle(fontSize:17, fontWeight: FontWeight.w400)),
                onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
                },
              ),
              TextButton(
                child: const Text("Đăng ký", style: TextStyle(fontSize:17, fontWeight: FontWeight.w400)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUp())
                  );
                },
              ),
            ],
          )
            ],
          ),
        ),
      ),
    );
  }
}
