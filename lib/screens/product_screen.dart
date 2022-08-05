import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/models/product.dart';
import 'package:computer_service_system/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product-screen';
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
        height: 800,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView.builder(
            itemCount: ProductModel.products.length,
            itemBuilder: (context, index){
              return ProductWidget(
                product: ProductModel.products[index],);
            },
          ),

        ),
      ),
    );
  }
}