import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/features/product_services.dart';
import 'package:computer_service_system/models/product.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product-screen';
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
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
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Accessory>>(
                future: ProductRequest.fetchPosts(token),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
        return Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: snapshot.data![index]);
              }),
        );
                  }
                })),

      ),
    );
  }
}
