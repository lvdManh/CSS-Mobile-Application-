

import 'package:computer_service_system/features/auth_services.dart';
import 'package:computer_service_system/screens/widgets/account_button.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account-screen';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              AccountButton(
                text: 'Log Out',
                onTap: () => AuthService().logOut(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}