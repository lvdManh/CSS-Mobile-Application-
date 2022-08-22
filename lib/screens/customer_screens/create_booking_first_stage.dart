
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/schedule_services.dart';
import 'package:computer_service_system/models/slot_data.dart';
import 'package:computer_service_system/screens/customer_screens/create_booking_second_stage.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
   List<Slot> futureSchedule =[];
   bool isSelected = false;
   final List<int> slots = [800, 930, 1100, 1230, 1400, 1530, 1700,1830];
   List<String> nextWeek = [];
   late String time;
   late String resultTime;
  Future<List<Slot>> getFutureSchedule() async {
    futureSchedule = await ScheduleServices().fetchSevenDaySlot();
    return futureSchedule;
  }
   List<String> weekday() {
     var timeNow = DateTime.now();
     nextWeek =
         List.generate(7, (i) => '${timeNow.add(Duration(days: i))}');
     return nextWeek;
   }
  String parseDate(time) {
    DateTime dt1 = DateTime.parse(time);
    return '${dt1.day}/${dt1.month}';
  }

   void combineTime(date,slotTime){
    String hour;
    String minute;
      hour = slotTime.toString().substring(0,slotTime.toString().length-2);
      if(hour.length==1){
        hour = '0$hour';
      }
      String result;
      result = date.toString().substring(0,11);
      minute = slotTime.toString().substring(slotTime.toString().length-2,slotTime.toString().length);
      setState(() {
        time = '$result$hour:$minute';
        resultTime = time;
      });
  }
   String showSlot(slotTime){
     String hour;
     String minute;
     hour = slotTime.toString().substring(0,slotTime.toString().length-2);
     if(hour.length==1){
       hour = '0$hour';
     }
     minute = slotTime.toString().substring(slotTime.toString().length-2,slotTime.toString().length);
     return time = '$hour:$minute';
   }

  @override
  void initState() {
    super.initState();
    time = '';
    resultTime ='';
  }

  int selectedDate = 0;
  int selectedSlot = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Chọn thời gian hẹn",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: FutureBuilder(
          future: getFutureSchedule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Chọn ngày hẹn",
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
                      child: ListView.builder(
                        itemCount: futureSchedule.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return demoDate(parseDate(futureSchedule[index].date), index);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Chọn thời gian",
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 25,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            childAspectRatio: 2.5, 
                            crossAxisSpacing: 10,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 8,
                          itemBuilder: (BuildContext ctx, index) {
                            if (index >= 8) {
                              return const Offstage ();
                            }
                            return isSlotAvailable(index)? workingSlot(
                                index+1,
                                slots[index].toString(),
                                index+1,
                                true): workingSlot(
                                index+1,
                                slots[index].toString(),
                                index+1,
                                false);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomButton(
                          text: "Tiếp tục",
                          onTap: () {
                            isSelected ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubmitAppointment(
                                            time: resultTime,)))
                                : AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.WARNING,
                              title: 'Hãy chọn thời gian hẹn',
                              dismissOnTouchOutside: false,
                              btnOkOnPress: () {},
                            ).show();
                          }
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  demoDate(String date, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = index;
          selectedSlot = 0;
          isSelected = false;
        });
      },
      child: index == selectedDate
          ? Container(
              width: 70,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                gradient: const LinearGradient(
                  colors: [Colors.amber,Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(width: 1.0, color: Colors.black54),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.red,
                    offset: Offset(1,2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: 70,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(width: 0.8, color: Colors.black54),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  bool isSlotAvailable(index){
    var timeNow = DateTime.now();
    int currentTime = convertTimeToInt(timeNow.hour.toString(), timeNow.minute.toString());
     final thisSlot = futureSchedule[selectedDate].slots.firstWhere((element)
      => element.slot == index+1,
         orElse: (){ return Slots(id: '0', slot: 0, start: 0, end: 0, status: '0', workSlot: [], scheduleId: '0');});
    if(thisSlot.status == 'Available'){
      if(thisSlot.start - currentTime < 10 && parseDate(futureSchedule[selectedDate].date.toString()) == parseDate(timeNow.toString()) ) {
        return false;
      }else{
        return true;
      }
    }
    return false;
  }
  
  workingSlot(int slot, String timeSlot, int index, bool isAvailable) {
    return GestureDetector(
      onTap: () {
        if (isAvailable == true) {
          final startTime = futureSchedule[selectedDate].slots.where((element) => element.slot == slot);
          setState(() {
            selectedSlot = index;
            isSelected = true;
            combineTime(futureSchedule[selectedDate].date, startTime.first.start);
          });
        }
      },
      child: index == selectedSlot
          ? Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                color: isAvailable ? Colors.blueGrey : Colors.grey,
                gradient: const LinearGradient(
                  colors: [Colors.amber,Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(width: 1.0, color: Colors.black54),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.red,
                    offset: Offset(1,2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      '$slot:',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      showSlot(timeSlot),
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
                color: isAvailable ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.2),
                border: Border.all(width: 0.8, color: Colors.black54),
                borderRadius: BorderRadius.circular(18),
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
                      '$slot:',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      showSlot(timeSlot),
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
