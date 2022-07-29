// import 'package:computer_service_system/constants/color_constant.dart';
// import 'package:computer_service_system/features/address_services.dart';
// import 'package:computer_service_system/models/hcm_address_data.dart';
// import 'package:flutter/material.dart';
//
// class Test extends StatefulWidget {
//   static const String routeName = '/test';
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   late Future<List<Address>> address;
//   String selectedDistrict;
//   String selectedWard;
//   @override
//   void initState() {
//     super.initState();
//     address = fetchHCMAddress();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orangeAccent,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.orangeAccent,
//         title: const Text(
//           "Dịch vụ",
//           style: TextStyle(
//             fontSize: 23,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             color: mBackgroundColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             )),
//         child: ListView(
//           padding: EdgeInsets.all(20.0),
//           children: [
//             // State Dropdown
//             DropdownButton<PostOffice>(
//               hint: Text('State'),
//               value: selectedState,
//               isExpanded: true,
//               items: states.map((PostOffice postOffice) {
//                 return DropdownMenuItem<PostOffice>(
//                   value: postOffice,
//                   child: Text(postOffice.state),
//                 );
//               }).toList(),
//               onChanged: onStateChange,
//             ),
//             // State Dropdown Ends here
//           ],
//         ),
//       ),
//     );
//   }
// }
