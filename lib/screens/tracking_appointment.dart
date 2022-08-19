import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/booking_services.dart';
import 'package:computer_service_system/models/booking_object.dart';
import 'package:computer_service_system/screens/widgets/appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_class.dart';

class TrackingAppointment extends StatefulWidget {
  static const String routeName = '/tracking-appointment';
  const TrackingAppointment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrackingAppointmentState();
}

class _TrackingAppointmentState extends State<TrackingAppointment> {
  List<Booking> bookingList = [];
  late List<String> selectStatus = ['Tất cả'];
  late String _selectedValue;
  late List<Booking> generateBookings = [];
  late Booking todayBooking = Booking();
  bool todayHave = false;
  Future<List<Booking>> getBookingListApi(token) async {
    bookingList = await BookingServices().fetchBooking(token);
    getStatusList();
    findTodayBooking();
    return bookingList;
  }

  String parseDate(time) {
    DateTime dt1 = DateTime.parse(time);
    return '${dt1.hour}:${dt1.minute}, ${dt1.day}/${dt1.month}/${dt1.year}';
  }

  void getStatusList() {
    for (var e in bookingList) {
      if (!selectStatus.contains(e.status)) {
        selectStatus.add(e.status!);
      }
    }
    setState(() {
      selectStatus;
    });
  }

  void showListBooking() {
    generateBookings.clear();
    if (_selectedValue == 'Tất cả') {
      generateBookings.addAll(bookingList);
    } else {
      for (var e in bookingList) {
        if (_selectedValue == e.status) {
          generateBookings.add(e);
        }
      }
    }
    setState(() {
      generateBookings;
    });
  }

  void findTodayBooking() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var result = bookingList.firstWhere((element) =>
        DateTime(
          DateTime.parse(element.time!).year,
          DateTime.parse(element.time!).month,
          DateTime.parse(element.time!).day,
        ) ==
        today);
    setState(() {
      if(result.id != null){
        todayHave = true;
        todayBooking = result;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = selectStatus.first;
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Lịch hẹn",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<List<Booking>>(
                  future: getBookingListApi(token),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return bookingList.isNotEmpty
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if(todayHave == true) Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentDetail(
                                                          bookings: todayBooking,
                                                        )));
                                          },
                                          child: const Center(child: Text('Hôm nay bạn có 1 lịch hẹn!',style: TextStyle(color: Colors.blue, fontSize: 16 , decoration: TextDecoration.underline))),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Trạng thái:  '),
                                        DropdownButton(
                                          // Initial Value
                                          value: _selectedValue,
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: selectStatus.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedValue = newValue!;
                                              showListBooking();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    generateBookings.isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: generateBookings.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  title: Text(
                                                      'Thời gian: ${parseDate(generateBookings[(generateBookings.length - 1) - index].time)}'),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 50, left: 0),
                                                    child: Text(
                                                      'Dịch vụ: ${generateBookings[(generateBookings.length - 1) - index].services!.join('\n').toString()}',
                                                      maxLines: 5,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                      generateBookings[
                                                              (generateBookings
                                                                          .length -
                                                                      1) -
                                                                  index]
                                                          .status
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: getStatusColor(
                                                              generateBookings[
                                                                      (generateBookings.length -
                                                                              1) -
                                                                          index]
                                                                  .status))),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AppointmentDetail(
                                                                  bookings: generateBookings[
                                                                      (generateBookings.length -
                                                                              1) -
                                                                          index],
                                                                )));
                                                  },
                                                ),
                                              );
                                            })
                                        : ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: bookingList.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  title: Text(
                                                      'Thời gian: ${parseDate(bookingList[(bookingList.length - 1) - index].time)}'),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 50, left: 0),
                                                    child: Text(
                                                      'Dịch vụ: ${bookingList[(bookingList.length - 1) - index].services!.join('\n').toString()}',
                                                      maxLines: 5,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                      bookingList[(bookingList
                                                                      .length -
                                                                  1) -
                                                              index]
                                                          .status
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: getStatusColor(
                                                              bookingList[
                                                                      (bookingList.length -
                                                                              1) -
                                                                          index]
                                                                  .status))),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AppointmentDetail(
                                                                  bookings: bookingList[
                                                                      (bookingList.length -
                                                                              1) -
                                                                          index],
                                                                )));
                                                  },
                                                ),
                                              );
                                            }),
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Chưa có lịch hẹn',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                    }
                  })),
        ),
      ),
    );
  }
}
