
import 'package:computer_service_system/models/staff_get_booking_object.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StaffCreateOrderPage extends StatefulWidget {
  static const String routeName = '/create_order_page';

  @override
  State<StaffCreateOrderPage> createState() => _StaffCreateOrderPageState();

  final Booking? booked;
  const StaffCreateOrderPage({super.key, required this.booked});
}

class _StaffCreateOrderPageState extends State<StaffCreateOrderPage> {
  int _selectedItemIndex = 1;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              //mã hóa đơn
              child: Text('Hóa đơn dịch vụ',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ))),
          //thông tin khách hàng - nhân viên
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Khách hàng: ${widget.booked?.cusName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nhân viên: ${widget.booked?.accId}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //thông tin dịch vụ
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Thông tin dịch vụ',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Loại dịch vụ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Thành tiền',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Cài lại win',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '50.000đ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Vệ sinh máy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '100.000đ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Thay quạt',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '1.000.000đ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tổng',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '1.150.000đ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày tạo: $formattedDate',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey),
                    )
                    // Text(
                    //   'Thời gian: 11h10p sáng, ngày 02/06/2022',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 10,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
          //button tạo hóa đơn
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Hình thức thanh toán',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      ' Thanh toán trực tiếp',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      ' Chuyển khoản VCB: 0021541235487',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      ' Chuyển khoản Momo: 0123456789',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomButton(text: 'Thêm dịch vụ', onTap: () {}),
                      CustomButton(text: 'Cập nhật', onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: const Text(
              "Hóa đơn đã tạo, đang chờ duyệt...",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
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

//   Widget _billingWidget() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const Text(
//           'Thông tin dịch vụ',
//           style: TextStyle(
//             color: Colors.orange,
//             fontSize: 15,
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text(
//               'Loại dịch vụ',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               'Thành tiền',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text(
//               'Cài lại win',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               '50.000đ',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text(
//               'Vệ sinh máy',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               '100.000đ',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: const [
//             Text(
//               'Thay quạt',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               '1.000.000đ',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text(
//               'Tổng',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               '1.150.000đ',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
}
