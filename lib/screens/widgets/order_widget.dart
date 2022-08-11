// import 'package:flutter/material.dart';

// import '../../models/staff_view_order.dart';


// class OrderWidget extends StatelessWidget {
//   final Order? order;

//   const OrderWidget({Key? key, required this.order}) : super(key: key);

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
//           print("Order ID: ${order?.id} pressed");
//         },
//         title: Text('${order?.orderDetailsId.}'),
//         subtitle: Text('${product?.description}'),
//         trailing: Text(
//           convertMoney(product?.price),
//           textScaleFactor: 1.1,
//           style: const TextStyle(
//             color: Colors.black54,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

