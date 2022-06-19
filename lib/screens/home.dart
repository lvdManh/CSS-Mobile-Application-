
import 'package:computer_service_system/screens/BookAppointmentScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItemIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Computer Services",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Text(
                      "Our Services",
                      style: TextStyle(
                      fontSize: 19,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
              ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      top: 30,
                    ),
                    child: Row(
                      children: [
                        _selectedService(
                            color: Colors.orangeAccent,
                        subtitle: "Booking door to door computer repair service",
                        title:"Repair computer" ),
                        _selectedService(
                            color: Colors.orangeAccent,
                            subtitle: "Advise online",
                            title:"Advise free" )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment', style: TextStyle(
                        fontSize: 20, color: Colors.black,
                      ),
                      ),
                      Padding(padding: EdgeInsets.only(
                          top: 20,
                      ),
                        child: Container(
                          height: 300,
                            child: GridView.count(
                                crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1.30,
                              children: [
                                _selectedAppointment(
                                  image: 'assets/icons/repair.jpg',
                                  name: 'Repair'
                                ),
                                _selectedAppointment(
                                    image: 'assets/icons/appoint.jpg',
                                    name: 'Schedule'
                                ),
                              ],
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
        // Container(
        //     padding: EdgeInsets.only(left: 13),
        //     child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //               padding: EdgeInsets.only(left: 6),
        //             child: Text(
        //               "Nearest Store",
        //               style: TextStyle(
        //                   fontSize:20,
        //                   color:Colors.black,
        //                   letterSpacing: 1,
        //                   fontWeight: FontWeight.w400
        //               ),
        //             ),
        //           ),
        //           SingleChildScrollView(
        //             scrollDirection: Axis.horizontal,
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: [
        //                 _selectNew(
        //                     title: 'iCare',
        //                   color: Colors.white,
        //                   border: Border.all(color: Colors.orangeAccent),
        //                   textStyle: TextStyle(color: Colors.orangeAccent),
        //                 ),
        //                 _selectNew(
        //                   title: 'capCuu',
        //                   color: Colors.white,
        //                   border: Border.all(color: Colors.grey),
        //                   textStyle: TextStyle(color: Colors.black),
        //                 ),
        //               ],
        //             ),
        //           )
        //         ],
        //     ),
        // ),
              ],
            )
        ),
      ),
      // Bottom Navigation
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
                border: Border(
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
            : BoxDecoration(),
        child: Icon(
          icon,
          color:
              index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
  Widget _selectedService({
      required Color color,
      required String title,
      required String subtitle,}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      height: 120,
        width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text(
            title,style: TextStyle(
            fontSize: 22, color: Colors.white,
          ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(subtitle,style: TextStyle(
            fontSize: 19, color: Colors.white70,
          ),)
        ],
      ),
    );
  }

  Widget _selectedAppointment({
    required String image,
    required String name,
  }
    ){
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointment()));
      },

    child: new Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey, width: 2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image))
              ),
          ),
          SizedBox(height: 10,),
          Text(name, style: TextStyle(fontSize: 17),)
        ],
      ),
    ),
    );
  }

  // Widget _selectNew({
  //   required Color color,
  //   required String title,
  //   required BoxBorder border,
  //   required TextStyle textStyle
  //   }
  //   ){
  //   return Container(
  //     height: 45,
  //     width: 120,
  //     margin: EdgeInsets.symmetric(horizontal: 7, vertical: 20),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(7),
  //       border: border,
  //     ),
  //     child: Center(
  //       child: Text(
  //         title,
  //         style: textStyle,
  //       ) ,
  //     ),
  //   );
  // }
}
