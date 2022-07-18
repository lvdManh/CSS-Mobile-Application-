import 'package:computer_service_system/screens/auth_screen.dart';
import 'package:computer_service_system/screens/home.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case NavScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NavScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Trang không tồn tại'),
          ),
        )
      );
  }
}
