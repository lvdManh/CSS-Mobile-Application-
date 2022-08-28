import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/order_services.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:computer_service_system/screens/staff_screens/staff_home_page.dart';
import 'package:computer_service_system/screens/staff_screens/staff_regist_work.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_details.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../providers/data_class.dart';
import '../widgets/account_screen.dart';

class HistoryOrder extends StatefulWidget {
  static const String routeName = '/history_order';
  const HistoryOrder({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  int _selectedItemIndex = 1;
  int currentPage = 1;
  late Future<List<OrderStaff>> futureOrderStaff;

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    futureOrderStaff = OrderServices().getHistoryOrderListForStaff(token,context);
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Lịch hẹn đã hoàn thành",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<OrderStaff>>(
              future: OrderServices().getHistoryOrderListForStaff(token, context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return snapshot.data!.isNotEmpty ? Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text(parseDateDownLine(snapshot.data![index].orderId?.bookingId?.time),textAlign: TextAlign.center,),
                            title: Text('Khách hàng: ${snapshot.data![index].orderId?.bookingId?.cusName}'),
                            subtitle:
                            Text('Địa chỉ: ${printAddress(snapshot.data![index].orderId?.bookingId?.cusAddress?.street,
                                snapshot.data![index].orderId?.bookingId?.cusAddress?.ward,
                                snapshot.data![index].orderId?.bookingId?.cusAddress?.district)}'),
                            trailing:
                            Text('${snapshot.data![index].orderId?.status}', style: TextStyle(color: getOrderStatusColor(snapshot.data![index].orderId?.status)),),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StaffViewAppointmentDetailsPage(
                                        order: snapshot.data![index],
                                        token: token,
                                      )));
                            },
                          ),
                        );
                      },
                    ),
                  ) : const Center(child: Text('Chưa có lịch hẹn'),);
                }
              }),
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.list_alt, 1),
          buildNavBarItem(Icons.schedule, 2),
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
        if(_selectedItemIndex == 1){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffViewAppointmentPage.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 0){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffHomePage.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 2){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffRegistWork.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 3){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const AccountScreen()
          ));
        }
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
