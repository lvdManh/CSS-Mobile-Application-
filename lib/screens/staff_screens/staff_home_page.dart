import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_page.dart';
import 'package:flutter/material.dart';

import '../account_screen.dart';

class StaffHomePage extends StatefulWidget {
  static const String routeName = '/staff_home_page';
  const StaffHomePage({Key? key}) : super(key: key);
  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  int _selectedItemIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Computer Services",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      //--------------------Body------
      body: Container(
        decoration: const BoxDecoration(color: mBackgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Xin chào!",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            //Button Xem lịch hẹn
            Container(
              width: 120,
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    "Xem lịch hẹn",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StaffViewAppointmentPage()),
                    );
                  }),
            ),
            //Button Đăng ký lịch làm việc
            Container(
              width: 120,
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    "Đăng ký lịch làm việc",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StaffRegistWork()),
                    );
                  }),
            ),
            //Button xem lịch làm việc
            Container(
              width: 120,
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    "Xem lịch làm việc",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {}),
            ),
            //Button lịch sử cuộc hẹn
            Container(
              width: 120,
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    "Lịch sử cuộc hẹn",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {}),
            ),
            Container(
              width: 120,
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    "Thông tin người dùng",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountScreen()),
                    );
                  }),
            ),
          ],
        ),
      ),
      // Bottom Navigation----------------
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.list_alt, 1),
          buildNavBarItem(Icons.notifications, 2),
          buildNavBarItem(Icons.person, 3)
        ],
      ),
      // This is Background Color
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class StaffRegistWork extends StatefulWidget {
//   static const String routeName = '/staff_regist_work';
//   const StaffRegistWork({Key? key}) : super(key: key);
//   @override
//   _StaffRegistWorkState createState() => _StaffRegistWorkState();
// }

// class _StaffRegistWorkState extends State<StaffRegistWork> {
//   int _selectedItemIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Bottom Navigation----------------
//       bottomNavigationBar: Row(
//         children: <Widget>[
//           buildNavBarItem(Icons.home, 0),
//           buildNavBarItem(Icons.list_alt, 1),
//           buildNavBarItem(Icons.notifications, 2),
//           buildNavBarItem(Icons.person, 3)
//         ],
//       ),
//       // This is Background Color
//     );
//   }

//   Widget buildNavBarItem(IconData icon, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedItemIndex = index;
//         });
//       },
//       child: Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width / 4,
//         decoration: index == _selectedItemIndex
//             ? BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(width: 4, color: Colors.orangeAccent),
//                 ),
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withOpacity(0.3),
//                     Colors.white.withOpacity(0.015),
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ))
//             : BoxDecoration(),
//         child: Icon(
//           icon,
//           color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
//         ),
//       ),
//     );
//   }
// }
