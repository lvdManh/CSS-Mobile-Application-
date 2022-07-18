
import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/auth_services.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/router.dart';
import 'package:computer_service_system/screens/auth_screen.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:computer_service_system/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataClass()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => AppState();
}

class AppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState(){
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Computer Services',
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        colorScheme: const ColorScheme.light(
          primary: mSecondaryColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<DataClass>(context).user.accessToken.isNotEmpty
        ? Provider.of<DataClass>(context).user.role == 'customer'
          ? const NavScreen()
          : const SignUp() //Chỗ này thay bằng Trang home của staff
          : const AuthScreen(),
    );

  }

}
