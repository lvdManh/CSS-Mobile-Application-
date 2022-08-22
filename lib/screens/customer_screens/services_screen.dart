import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/models/services_data.dart';
import 'package:computer_service_system/providers/data_class.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/service_services.dart';

class ServicesScreen extends StatefulWidget {
  static const String routeName = '/services-screen';
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late List<Service> futureService =[];
  late List<String> selectTypes = ['Tất cả'];
  late String _selectedValue;
  late List<Service> serviceList = [];
  Future<List<Service>> getFutureService(token) async {
    futureService = await ServiceServices().fetchServices(token);
    getTypeList();
    return futureService;
  }
void getTypeList(){
  for(var e in futureService){
    if(!selectTypes.contains(e.type)){
      selectTypes.add(e.type!);
    }
  }
  setState(() {
    selectTypes;
  });
}

  void showListService(){
    serviceList.clear();
    if(_selectedValue == 'Tất cả'){
      serviceList.addAll(futureService);
    } else {
      for (var e in futureService) {
        if (_selectedValue == e.type) {
          serviceList.add(e);
        }
      }
    }
    setState(() {
      serviceList;
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
            "Dịch vụ",
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
            child: FutureBuilder<List<Service>>(
                future: getFutureService(token),
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
                                      showListService();
                                    });
                                  },
                                ),
                              ],
                            ),
                            serviceList.isNotEmpty ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: serviceList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Text('${serviceList[index].type}'),
                                      title: Text(
                                          'Dịch vụ: ${serviceList[index].name}'),
                                      subtitle: Text(
                                          'Mô tả: ${serviceList[index].description.toString()}'),
                                      trailing: Text(
                                          '${convertMoney(serviceList[index].price)} đ'),
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
                                itemCount: futureService.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Text('${futureService[index].type}'),
                                      title: Text(
                                          'Dịch vụ: ${futureService[index].name}'),
                                      subtitle: Text(
                                          'Mô tả: ${futureService[index].description.toString()}'),
                                      trailing: Text(
                                          '${convertMoney(futureService[index].price)} đ'),
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
                    ): const Center(child: Text('Hiện chưa có dịch vụ'),);
                  }
                })),
      ),
    );
  }
}
