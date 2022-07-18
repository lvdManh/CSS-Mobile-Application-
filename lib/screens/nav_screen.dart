import 'package:badges/badges.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/account_screen.dart';
import 'package:computer_service_system/screens/product_screen.dart';
import 'package:computer_service_system/screens/tracking_appointment.dart';
import 'package:computer_service_system/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  static const String routeName = '/actual-home';
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;
  List<Widget> tabPages = [
    const HomePage(),
    const TrackingAppointment(),
    const ProductScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: tabPages[currentIndex],
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.list_alt, 1),
          buildNavBarItem(Icons.notifications, 2),
          buildNavBarItem(Icons.person, 3)
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    final userBookingLen = context.watch<DataClass>().user.booking.length;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == currentIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : const BoxDecoration(),
        child: index == 1
            ? Badge(
                elevation: 0,
                badgeContent: Text(userBookingLen.toString()),
                badgeColor: Colors.white,
                child: Icon(
                  icon,
                  size: index == currentIndex ? 36 : 26,
                  color:
                      index == currentIndex ? Colors.redAccent : Colors.white,
                ),
              )
            : Icon(
                icon,
                size: index == currentIndex ? 36 : 26,
                color: index == currentIndex ? Colors.redAccent : Colors.white,
              ),
      ),
    );
  }
} //end class _Nav
