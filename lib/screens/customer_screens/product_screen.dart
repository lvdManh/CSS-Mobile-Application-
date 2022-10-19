import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/product_services.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/accessory_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/accessory_data.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product-screen';
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String sortPrice = 'Nhỏ nhất';
  String sortTypeCom = 'Tất cả';
  List<String> deviceType = ['Tất cả', 'PC','Laptop','Mac'];
  List<String> priceList = ['Lớn nhất', 'Nhỏ nhất'];
  Widget customSearchBar = const Text('Linh kiện');
  Icon customIcon = const Icon(Icons.search);
  String findFilter ='';
  @override
  void initState() {
    super.initState();
    findFilter = '';
  }
  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                        leading: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                    ),
                      title: TextField(
                        onEditingComplete: () {
                          setState(() {
                            findFilter;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            findFilter = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nhập tên linh kiện',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Linh kiện');
                  }
                });
              },
              icon: customIcon,
            )
          ],
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<AccessoryMix>(
                  future:
                      ProductRequest().fetchAccessorySort(token, sortPrice,'desc',sortTypeCom,findFilter),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Text('Giá tiền: '),
                                  DropdownButton(
                                    // Initial Value
                                    value: sortPrice,
                                    // Down Arrow Icon
                                    icon:
                                        const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: priceList.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        sortPrice = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Loại: '),
                                  DropdownButton(
                                    // Initial Value
                                    value: sortTypeCom,
                                    // Down Arrow Icon
                                    icon:
                                    const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: deviceType.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        sortTypeCom = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: GridView.count(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 16,
                              crossAxisCount: 2,
                              children: snapshot.data!.accessories!
                                  .map((Accessories product) {
                                return buildContent(product, context);
                              }).toList(),
                            ),
                          )
                        ],
                      );
                    }
                  })),
        ),
      ),
    );
  }
}

Widget buildContent(Accessories product, context) {
  return Stack(children: [
    Card(
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white60,
      color: mBackgroundColor.withOpacity(0.8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.tealAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
              return AccessoryDetailScreen(accessory: product);
            },
            );
          },
          child: Stack(children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text('đ${convertMoney(product.price)}'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.tealAccent.withOpacity(0.9),
                        BlendMode.dstATop),
                    child: Image.network(
                      '${product.imgUrl}',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Text('${product.name}',
                    style: const TextStyle(
                        color: Color(0xff0a1034),
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Text('B/h: ${product.insurance}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300)),
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    ),
  ]);
}
