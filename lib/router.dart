import 'package:computer_service_system/screens/widgets/account_screen.dart';
import 'package:computer_service_system/screens/widgets/auth_screen.dart';
import 'package:computer_service_system/screens/customer_screens/create_booking_first_stage.dart';
import 'package:computer_service_system/screens/customer_screens/home.dart';
import 'package:computer_service_system/screens/customer_screens/nav_screen.dart';
import 'package:computer_service_system/screens/customer_screens/product_screen.dart';
import 'package:computer_service_system/screens/customer_screens/services_screen.dart';
import 'package:computer_service_system/screens/customer_screens/create_booking_second_stage.dart';
import 'package:computer_service_system/screens/staff_screens/staff_home_page.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_page.dart';
import 'package:computer_service_system/screens/customer_screens/tracking_appointment.dart';
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
        builder: (_) => const BookAppointment(),
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
    case ProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProductScreen(),
      );
    case StaffHomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StaffHomePage(),
      );
    case StaffViewAppointmentPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StaffViewAppointmentPage(),
      );
    case StaffRegistWork.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StaffRegistWork(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Trang không tồn tại'),
                ),
              ));
  }
}
