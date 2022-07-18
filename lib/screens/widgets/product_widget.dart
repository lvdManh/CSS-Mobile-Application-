import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product})
      : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          print("${product.name} pressed");
        },
        leading: Image.network(product.imgUrl),
        title: Text(product.name,
        ),
        subtitle: Text(product.description),
        trailing: Text(product.price.toString(),
          textScaleFactor: 1.1,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),),
      ),
    );
  }
}


