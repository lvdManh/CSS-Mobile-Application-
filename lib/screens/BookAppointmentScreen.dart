import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/screens/SubmitAppointmentScreen.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
   int selectedDate =0;
   int selectedSlot =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Sửa chữa tại nhà",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: 800,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 30),
                alignment: Alignment.center,
                child: const Text(
                  "Ngày",
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    demoDate("Sat", "25/6", 0),
                    demoDate("Sun", "26/6", 1),
                    demoDate("Mon", "27/6", 2),
                    demoDate("Tue", "28/6", 3),
                    demoDate("Wed", "29/6", 4),
                    demoDate("Thr", "30/6", 5),
                    demoDate("Fri", "1/7", 6),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 30),
                alignment: Alignment.center,
                child: const Text(
                  "Giờ",
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  children: [
                    workingSlot("Slot 1", "8:00", 1, false),
                    workingSlot("Slot 2", "9:30", 2, false),
                    workingSlot("Slot 3", "11:00", 3, true),
                    workingSlot("Slot 4", "13:00", 4, true),
                    workingSlot("Slot 5", "14:30", 5, true),
                    workingSlot("Slot 6", "16:00", 6, true),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubmitAppointment()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff107163),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Tiếp tục',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  demoDate(String day, String date, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = index;
        });
      },
      child: index == selectedDate
          ? Container(
              width: 70,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: const Color(0xff107163),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(
              width: 70,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  workingSlot(String slot, String time, int index, bool isAvailable) {
    return GestureDetector(
      onTap: () {
        if (isAvailable == true) {
          setState(() {
            selectedSlot = index;
          });
        }
      },
      child: index == selectedSlot
          ? Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                color: isAvailable ? const Color(0xff107163) : Colors.grey,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1.0, color: Colors.black54),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 2),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      slot,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      time,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                color:
                isAvailable ? const Color(0xffEEEEEE) : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      slot,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      time,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
