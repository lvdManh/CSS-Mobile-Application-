// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:computer_service_system/models/staff_view_order.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StaffViewOrderPage extends StatefulWidget {
  static const String routeName = '/staff_view_order_page';

  @override
  State<StaffViewOrderPage> createState() => _StaffViewOrderPageState();

  const StaffViewOrderPage({Key? key}) : super(key: key);
}

class _StaffViewOrderPageState extends State<StaffViewOrderPage> {
  int _selectedItemIndex = 1;
  List<Order> listOrder = [];

  Future<List<Order>> getOrderData() async {
    final user = context.watch<DataClass>().user;
    listOrder.clear();
    final response = await http.get(
      Uri.parse(
          "http://computer-services-api.herokuapp.com/order/show/order-staff"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'bearer ${user.accessToken}',
      },
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      listOrder.clear();
      for (Map i in data) {
        listOrder.add(Order.fromJson(i));
      }
      return listOrder;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get order');
    }
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    return Scaffold(
      //App Bar
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                //mã hóa đơn
                child: Text('Thông tin lịch hẹn',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
            FutureBuilder(
                future: getOrderData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return listOrder.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listOrder.length,
                            itemBuilder: (context, index) {
                              return Card(
                                // child: ListTile(
                                //   title: Text(
                                //       'Khách hàng: ${listOrder[index].orderId?.bookingId?.cusName}'),
                                //   subtitle: Text(
                                //       'Số điện thoại: ${listOrder[index].orderId?.bookingId?.phonenum}'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Tên khách hàng: ${listOrder[index].orderId?.bookingId?.cusName}\nSố điện thoại: ${listOrder[index].orderId?.bookingId?.phonenum}\nĐịa chỉ: ${listOrder[index].orderId?.bookingId?.cusAddress?.ward}, ${listOrder[index].orderId?.bookingId?.cusAddress?.street}, ${listOrder[index].orderId?.bookingId?.cusAddress?.district}, ${listOrder[index].orderId?.bookingId?.cusAddress?.city}',
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                // ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'Đang tải dữ liệu...',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
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
