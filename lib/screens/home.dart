import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/screens/BookAppointmentScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Computer Service",
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
                color: mBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Text(
                      "Dịch vụ",
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
                      left: 20,
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        _selectedService(
                            color: Colors.orangeAccent,
                        subtitle: "Sữa chữa phần cứng, phần mềm",
                        title:"Sửa chữa" ),
                        _selectedService(
                            color: Colors.orangeAccent,
                            subtitle: "Cung cấp dịch vụ vệ sinh máy tính",
                            title:"Vệ sinh máy tính" ),
                        _selectedService(
                            color: Colors.orangeAccent,
                            subtitle: "Cung cấp linh kiện máy tính giá ưu đãi",
                            title:"Thay thế linh kiện" ),
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
                        'Danh sáchs', style: TextStyle(
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
                              childAspectRatio: 1.50,
                              children: [
                                _selectedAppointment(
                                  image: 'assets/icons/repair.png',
                                  name: 'Đặt lịch'
                                ),
                                _selectedAppointment(
                                    image: 'assets/icons/schedule.png',
                                    name: 'Lịch hẹn'
                                ),
                                _selectedAppointment(
                                    image: 'assets/icons/R.png',
                                    name: 'Linh kiện'
                                ),
                                _selectedAppointment(
                                    image: 'assets/icons/store.png',
                                    name: 'Cửa hàng'
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
      // This is Background Color

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
