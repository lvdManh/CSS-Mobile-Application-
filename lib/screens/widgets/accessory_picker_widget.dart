import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/service_services.dart';
import 'package:computer_service_system/models/accessory_choose_data.dart';
import 'package:computer_service_system/models/service_choose_data.dart';
import 'package:computer_service_system/models/service_list_data.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/computer_type_object.dart';

class AccessoryPicker extends StatefulWidget {
  const AccessoryPicker({Key? key}) : super(key: key);

  @override
  State<AccessoryPicker> createState() => _AccessoryPickerState();
}

class _AccessoryPickerState extends State<AccessoryPicker> {
  late bool hasAccessory = false;
  late String typeSer;
  late int servicePick = -1;
  late String selectedComType;
  late List<String> selected = [];
  late ServiceAccessoryList _serviceAccessoryList;
  late List<ServiceToChoose> _serviceToChoose;
  late List<AccessoryToChoose> _accessoryToChoose;
  Future<List<ServiceToChoose>> getServiceList(token) async {
    String ts = typeSer;
    if (ts == "Tất cả") {
      ts = '';
      hasAccessory = false;
    }
    if (typeSer == "Thay linh kiện") {
      ts = '';
      setState(() {
        hasAccessory = true;
      });
    } else {
      setState(() {
        hasAccessory = false;
      });
    }
    _serviceToChoose = await ServiceServices()
        .fetchServiceToPick(token, false, selectedComType, ts);
    return _serviceToChoose;
  }

  Future<List<AccessoryToChoose>> getAccessoryList(token) async {
    if (typeSer == "Tất cả") {
      hasAccessory = false;
    }
    if (typeSer == "Thay linh kiện") {
      setState(() {
        hasAccessory = true;
      });
    } else {
      setState(() {
        hasAccessory = false;
      });
    }
    _accessoryToChoose = await ServiceServices()
        .fetchAccessoryServiceToPick(token, hasAccessory, selectedComType);
    return _accessoryToChoose;
  }

  var textValue = 'Không';

  void toggleSwitch(bool value) {
    if (hasAccessory == false) {
      setState(() {
        hasAccessory = true;
        textValue = 'Có';
      });
    } else {
      setState(() {
        hasAccessory = false;
        servicePick = -1;
        textValue = 'Không';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedComType = deviceType.first;
    typeSer = typeService.first;
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
              heightFactor: 0.75,
              child: Container(
                decoration: const BoxDecoration(
                    color: mBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Row(
                          //   children: [
                          //     const Text('Linh kiện:'),
                          //     Switch(
                          //       onChanged: toggleSwitch,
                          //       value: hasAccessory,
                          //       activeColor: Colors.red,
                          //       activeTrackColor: Colors.orangeAccent,
                          //       inactiveThumbColor: Colors.red,
                          //       inactiveTrackColor: Colors.black12,
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              const Text('Dịch vụ: '),
                              DropdownButton(
                                // Initial Value
                                value: typeSer,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: typeService.map((String items) {
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
                                    typeSer = newValue!;
                                    servicePick = -1;
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
                                value: selectedComType,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
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
                                    selectedComType = newValue!;
                                    servicePick = -1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                  typeSer == 'Thay linh kiện'
                      ? Expanded(
                          child: FutureBuilder<List<AccessoryToChoose>>(
                              future: getAccessoryList(token),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return snapshot.data!.isNotEmpty
                                      ? Align(
                                          alignment: Alignment.topCenter,
                                          child: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          Card(
                                                            child: ListTile(
                                                              title: Text(
                                                                  '${snapshot.data![index].name}'),
                                                              subtitle: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            50),
                                                                child: Text(
                                                                  '${snapshot.data![index].description}',
                                                                  maxLines: 5,
                                                                ),
                                                              ),
                                                              trailing: servicePick ==
                                                                      index
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,color: Colors.green,)
                                                                  : Text(
                                                                      '${convertMoney(snapshot.data![index].price)}đ'),
                                                              onTap: () {
                                                                selected
                                                                    .clear();
                                                                if (servicePick !=
                                                                        index &&
                                                                    hasAccessory ==
                                                                        true) {
                                                                  servicePick =
                                                                      index;
                                                                  _serviceAccessoryList = ServiceAccessoryList(
                                                                      serviceAccessory: ServiceAccessory(
                                                                          hasAccessory:
                                                                              true,
                                                                          price: _accessoryToChoose[index]
                                                                              .price,
                                                                          id: _accessoryToChoose[index]
                                                                              .id,
                                                                          name: _accessoryToChoose[index]
                                                                              .name,
                                                                          type:
                                                                              _accessoryToChoose[index].type,
                                                                          serHasAcc: []));
                                                                } else {
                                                                  servicePick =
                                                                      -1;
                                                                }
                                                                setState(() {
                                                                  selected;
                                                                  servicePick;
                                                                  _serviceAccessoryList;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          //accessory place
                                                          if (servicePick ==
                                                              index)
                                                            GridView.builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount:
                                                                  _accessoryToChoose[
                                                                          index]
                                                                      .serHasAcc
                                                                      ?.length,
                                                              shrinkWrap: true,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              itemBuilder:
                                                                  (ctx, i) {
                                                                return Card(
                                                                  shadowColor:
                                                                      Colors
                                                                          .brown,
                                                                  surfaceTintColor:
                                                                      Colors
                                                                          .tealAccent,
                                                                  color: mBackgroundColor
                                                                      .withOpacity(
                                                                          0.8),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white54,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      gradient:
                                                                          const LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .tealAccent,
                                                                          Colors
                                                                              .white60
                                                                        ],
                                                                        begin: Alignment
                                                                            .topRight,
                                                                        end: Alignment
                                                                            .bottomLeft,
                                                                      ),
                                                                    ),
                                                                    margin: const EdgeInsets
                                                                        .all(5),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (!selected.contains(_accessoryToChoose[index]
                                                                            .serHasAcc![i]
                                                                            .id)) {
                                                                          selected.add(_accessoryToChoose[index]
                                                                              .serHasAcc![i]
                                                                              .id!);
                                                                          _serviceAccessoryList.serviceAccessory!.serHasAcc!.add(SerHasAcc(
                                                                              id: _accessoryToChoose[index].serHasAcc![i].id,
                                                                              amount: 1,
                                                                              accessoryId: AccessoryIdL(
                                                                                id: _accessoryToChoose[index].serHasAcc![i].accessoryId!.id,
                                                                                name: _accessoryToChoose[index].serHasAcc![i].accessoryId!.name,
                                                                                price: _accessoryToChoose[index].serHasAcc![i].accessoryId!.price,
                                                                                insurance: _accessoryToChoose[index].serHasAcc![i].accessoryId!.insurance,
                                                                              )));
                                                                        } else {
                                                                          _serviceAccessoryList
                                                                              .serviceAccessory!
                                                                              .serHasAcc!
                                                                              .removeWhere((element) => element.id == _accessoryToChoose[index].serHasAcc![i].id);
                                                                          selected.remove(_accessoryToChoose[index]
                                                                              .serHasAcc![i]
                                                                              .id);
                                                                          setState(
                                                                              () {
                                                                            selected;
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          selected.contains(_accessoryToChoose[index].serHasAcc![i].id)
                                                                              ? Align(
                                                                                  alignment: Alignment.bottomRight,
                                                                                  child: Icon(Icons.check,color: Colors.green,),
                                                                                )
                                                                              : Align(
                                                                                  alignment: Alignment.bottomRight,
                                                                                  child: Text('${_accessoryToChoose[index].serHasAcc![i].accessoryId!.insurance}'),
                                                                                ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.stretch,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Image.asset(
                                                                                  checkAccessoryName(_accessoryToChoose[index].serHasAcc?[i].accessoryId!.name),
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Text('${_accessoryToChoose[servicePick].serHasAcc?[i].accessoryId!.name}', style: const TextStyle(color: Color(0xff0a1034), fontSize: 15, fontWeight: FontWeight.w400)),
                                                                              Row(
                                                                                children: [
                                                                                  Text('${convertMoney(_accessoryToChoose[servicePick].serHasAcc?[i].accessoryId!.price)}đ', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                childAspectRatio:
                                                                    1.0,
                                                                crossAxisSpacing:
                                                                    8,
                                                                mainAxisSpacing:
                                                                    8,
                                                              ),
                                                            ),
                                                        ],
                                                      );
                                                    })
                                              ])))
                                      : const Center(child: Text('Trống'));
                                }
                              }))
                      : FutureBuilder(
                          future: getServiceList(token),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return _serviceToChoose.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    _serviceToChoose.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: ListTile(
                                                      title: Text(
                                                          '${_serviceToChoose[index].name}'),
                                                      subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 50),
                                                        child: Text(
                                                          '${_serviceToChoose[index].description}',
                                                          maxLines: 5,
                                                        ),
                                                      ),
                                                      trailing: servicePick ==
                                                              index
                                                          ? const Icon(
                                                              Icons.check,color: Colors.green,)
                                                          : Text(
                                                              '${convertMoney(_serviceToChoose[index].price)}đ'),
                                                      onTap: () {
                                                        servicePick = index;
                                                        _serviceAccessoryList =
                                                            ServiceAccessoryList(
                                                                serviceAccessory:
                                                                ServiceAccessory(
                                                                  hasAccessory:
                                                                  false,
                                                                  price:
                                                                  _serviceToChoose[
                                                                  index]
                                                                      .price,
                                                                  id: _serviceToChoose[
                                                                  index]
                                                                      .id,
                                                                  name:
                                                                  _serviceToChoose[
                                                                  index]
                                                                      .name,
                                                                  type:
                                                                  _serviceToChoose[
                                                                  index]
                                                                      .type,
                                                                ));
                                                        setState(() {
                                                          servicePick;
                                                          _serviceAccessoryList;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('Trống'),
                                    );
                            }
                          })
                ]),
              ))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context,_serviceAccessoryList);
        },
        icon: const Icon(Icons.add),
        label: const Text('Xác nhận'),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String checkAccessoryName(name) {
    if (name.toString().toLowerCase().contains('ram')) {
      return 'assets/images/ram.png';
    } else if (name.toString().toLowerCase().contains('cpu')) {
      return 'assets/images/cpu.png';
    } else if (name.toString().toLowerCase().contains('mainboard')) {
      return 'assets/images/mainboard.png';
    } else if (name.toString().toLowerCase().contains('window')) {
      return 'assets/images/windows.jpg';
    } else {
      return 'assets/images/white.png';
    }
  }
}
