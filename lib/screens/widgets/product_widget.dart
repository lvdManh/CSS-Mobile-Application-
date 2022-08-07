import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductWidget extends StatelessWidget {
  final Accessory? product;

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
    return Card(
      child: ListTile(
        onTap: () {
          print("${product?.name} pressed");
        },
        leading: Image(
          image: AssetImage(checkAccessoryName()),
          width: 70,
        ),
        title: Text('${product?.name}'),
        subtitle: Text('${product?.description}'),
        trailing: Text(
          convertMoney(product?.price),
          textScaleFactor: 1.1,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String checkAccessoryName() {
    if (product?.name == 'RAM') {
      return 'assets/images/ram.png';
    } else if (product?.name == 'CPU') {
      return 'assets/images/cpu.png';
    } else if (product?.name == 'Mainboard') {
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
