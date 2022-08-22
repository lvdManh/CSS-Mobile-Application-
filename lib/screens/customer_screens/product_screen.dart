import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/product_services.dart';
import 'package:computer_service_system/providers/data_class.dart';
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

  late List<Accessory> futureAccessory =[];
  late List<String> selectTypes = ['Tất cả'];
  late String _selectedValue;
  late List<Accessory> accessoryList = [];
  Future<List<Accessory>> getFutureAccessory(token) async {
    futureAccessory = await ProductRequest().fetchAccessory(token);
    getTypeList();
    return futureAccessory;
  }
  void getTypeList(){
    for(var e in futureAccessory){
      if(!selectTypes.contains(e.supplierId?.name)){
        selectTypes.add(e.supplierId!.name!);
      }
    }
    setState(() {
      selectTypes;
    });
  }

  void showListAccessories(){
    accessoryList.clear();
    if(_selectedValue == 'Tất cả'){
      accessoryList.addAll(futureAccessory);
    } else {
      for (var e in futureAccessory) {
        if (_selectedValue == e.supplierId?.name) {
          accessoryList.add(e);
        }
      }
    }
    setState(() {
      accessoryList;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue= selectTypes.first;
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
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<List<Accessory>>(
                future: getFutureAccessory(token),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return snapshot.data!.isNotEmpty? Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                const Text('Lọc:  '),
                                DropdownButton(
                                  // Initial Value
                                  value: _selectedValue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items:
                                  selectTypes.map((String items) {
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
                                      _selectedValue = newValue!;
                                      showListAccessories();
                                    });
                                  },
                                ),
                              ],
                            ),
                            accessoryList.isNotEmpty ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: accessoryList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Text('${accessoryList[index].supplierId?.name}'),
                                      title: Text(
                                          '${accessoryList[index].name}'),
                                      subtitle: Text(
                                          'Mô tả: ${accessoryList[index].description.toString()}'),
                                      trailing: Text(
                                          '${convertMoney(accessoryList[index].price)} đ'),
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => ServiceDetail(
                                        //               service: serviceList[index],
                                        //             )));
                                      },
                                    ),
                                  );
                                }): ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: futureAccessory.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Text('${futureAccessory[index].supplierId?.name}'),
                                      title: Text(
                                          'Dịch vụ: ${futureAccessory[index].name}'),
                                      subtitle: Text(
                                          'Mô tả: ${futureAccessory[index].description.toString()}'),
                                      trailing: Text(
                                          '${convertMoney(futureAccessory[index].price)} đ'),
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => ServiceDetail(
                                        //               service: serviceList[index],
                                        //             )));
                                      },
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ): const Center(child: Text('Hiện chưa có nhóm linh kiện này'),);
                  }
                })),
      ),
    );
  }
}
