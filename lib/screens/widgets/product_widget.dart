import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constant.dart';
import '../../models/accessory_data.dart';

class ProductWidget extends StatelessWidget {
  final Accessories product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  String convertMoney(int? price) {
    // final value = "XPTOXXSFXBAC"
    //     .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
    // print("value: $value");
    String converted = price.toString().replaceAllMapped(
        RegExp(r"(?<=\d)(?=(\d\d\d)+(?!\d))"), (match) => "${match.group(0)}.");
    return converted;
  }

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
              "Linh kiện",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .35,
                padding: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                child: Image.network(product.imgUrl!),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chanel',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tên linh kiện',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$135.00',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  String checkAccessoryName() {
    if (product.name == 'RAM') {
      return 'assets/images/ram.png';
    } else if (product.name == 'CPU') {
      return 'assets/images/cpu.png';
    } else if (product.name == 'Mainboard') {
      return 'assets/images/mainboard.png';
    } else {
      return 'assets/images/white.png';
    }
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         onTap: () {
//           print("${product?.name} pressed");
//         },
//         leading: Image(
//           image: AssetImage(checkAccessoryName()),
//           width: 70,
//         ),
//         title: Text('${product?.name}'),
//         subtitle: Text('${product?.description}'),
//         trailing: Text(
//           convertMoney(product?.price),
//           textScaleFactor: 1.1,
//           print("${product.name} pressed");
//         },
//         leading: Image.network(product.imgUrl),
//         title: Text(
//           product.name,
//         ),
//         subtitle: Text(product.description),
//         trailing: Text(
//           product.price.toString(),

//           textScaleFactor: 1.1,
//           style: const TextStyle(
//             color: Colors.black54,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   String checkAccessoryName() {
//     if (product?.name == 'RAM') {
//       return 'assets/images/ram.png';
//     } else if (product?.name == 'CPU') {
//       return 'assets/images/cpu.png';
//     } else if (product?.name == 'Mainboard') {
//       return 'assets/images/mainboard.png';
//     } else {
//       return 'assets/images/white.png';
//     }
//   }

// }
