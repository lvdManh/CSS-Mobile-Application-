import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/product_services.dart';
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
  List<Accessory>? listProduct;

  // Future<List<Accessory>?> getAccessoryListApi() async {
  //   ProductRequest.fetchPosts().then((dataFromSever) {
  //     setState(() {
  //       listProduct = dataFromSever;
  //     });
  //   });
  //   return listProduct;
  // }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ProductRequest.fetchPosts().then((dataFromSever) {
      setState(() {
        listProduct = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
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
        // child: Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: FutureBuilder(
        //         future: getAccessoryListApi(),
        //         builder: (context, snapshot) {
        //           if (!snapshot.hasData) {
        //             return const Center(child: CircularProgressIndicator());
        //           } else {
        // Expanded(
        //   child: ListView.builder(
        //       padding: const EdgeInsets.all(16.0),
        //       itemCount: listProduct?.length,
        //       itemBuilder: (context, index) {
        //         return ProductWidget(product: listProduct?[index]);
        //       }),
        // );
        //           }
        //           throw "";
        //         })),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemCount: listProduct?.length,
                itemBuilder: (context, index) {
                  return ProductWidget(product: listProduct?[index]);
                }),
          )
        ]),
      ),
    );
  }
}
