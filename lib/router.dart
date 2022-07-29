import 'package:computer_service_system/screens/account_screen.dart';
import 'package:computer_service_system/screens/auth_screen.dart';
import 'package:computer_service_system/screens/home.dart';
import 'package:computer_service_system/screens/nav_screen.dart';
import 'package:computer_service_system/screens/services_screen.dart';
import 'package:computer_service_system/screens/submit_booking_screen.dart';
import 'package:computer_service_system/screens/tracking_appointment.dart';
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
    case TrackingAppointment.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TrackingAppointment(),
      );
    case SubmitAppointment.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SubmitAppointment(),
      );
    case AccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountScreen(),
      );
    case ServicesScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ServicesScreen(),
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
