// import 'package:computer_service_system/models/staff_view_order.dart';
// import 'package:flutter/material.dart';

// class OrderListWidget extends StatelessWidget {
//   final Order? order;

//   const OrderListWidget({Key? key, required this.order}) : super(key: key);

//   String convertMoney(int? price) {
//     // final value = "XPTOXXSFXBAC"
//     //     .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
//     // print("value: $value");
//     String converted = price.toString().replaceAllMapped(
//         RegExp(r"(?<=\d)(?=(\d\d\d)+(?!\d))"), (match) => "${match.group(0)}.");
//     return converted;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         onTap: () {
//           print("${order?.orderId?.bookingId?.accId} pressed");
//         },
//         title: Text('Khách hàng: ${order?.orderId?.bookingId?.cusName}'),
//         subtitle: Text('Số điện thoại: ${order?.orderId?.bookingId?.phonenum}'),
//       ),
//     );
//   }
// }
