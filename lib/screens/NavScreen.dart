import 'package:computer_service_system/screens/TrackingAppointment.dart';
import 'package:computer_service_system/screens/home.dart';
import 'package:flutter/material.dart';
class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen>{
  int currentIndex = 0;
  final tabPages =[
    HomePage(),
    TrackingAppointment(),

    Container(
      child: Center(
        child: Text('Notifications',style: TextStyle(fontSize: 30)),
      ),
    ),
    Container(
      child: Center(
        child: Text('Profile',style: TextStyle(fontSize: 30)),
      ),
    )
  ];

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
            border: Border(
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
            : BoxDecoration(),
        child: Icon(
          icon,
          size:
          index == currentIndex ? 36 : 26,
          color:
          index == currentIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }


}//end class _Nav

