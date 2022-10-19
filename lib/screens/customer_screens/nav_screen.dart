
import 'package:computer_service_system/screens/widgets/account_screen.dart';
import 'package:computer_service_system/screens/customer_screens/product_screen.dart';
import 'package:computer_service_system/screens/customer_screens/tracking_appointment.dart';
import 'package:computer_service_system/screens/customer_screens/home.dart';
import 'package:flutter/material.dart';


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
  void initState(){
    super.initState();
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
          buildNavBarItem(Icons.devices, 2),
          buildNavBarItem(Icons.person, 3)
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
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
        child: Icon(
                icon,
                size: index == currentIndex ? 36 : 26,
                color: index == currentIndex ? Colors.redAccent : Colors.white,
              ),
      ),
    );
  }
} //end class _Nav
