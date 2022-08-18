import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/service_services.dart';
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
  late List<ServiceAccessory> _futureSerAcc;
  late bool hasAccessory = false;
  late String brandCom;
  late String typeSer = '';
  late int servicePick = -1;
  late String selectedComType;
  Future<List<ServiceAccessory>> getSerAndAcc(token) async {
    _futureSerAcc = await ServiceServices().fetchServiceToPick(
        token, hasAccessory, selectedComType, brandCom, typeSer);
    return _futureSerAcc;
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
    brandCom = deviceBranch.first;
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
            child: Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Text('Linh kiện:'),
                            Switch(
                              onChanged: toggleSwitch,
                              value: hasAccessory,
                              activeColor: Colors.red,
                              activeTrackColor: Colors.orangeAccent,
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.black12,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Hãng: '),
                            DropdownButton(
                              // Initial Value
                              value: brandCom,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: deviceBranch.map((String items) {
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
                                  brandCom = newValue!;
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
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
                Expanded(
                  child: FutureBuilder<List<ServiceAccessory>>(
                      future: getSerAndAcc(token),
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
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        servicePick == -1
                                            ? ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: ListTile(
                                                      title: Text(
                                                          '${snapshot.data![index].name}'),
                                                      subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 50),
                                                        child: Text(
                                                          '${snapshot.data![index].description}',
                                                          maxLines: 5,
                                                        ),
                                                      ),
                                                      trailing: Text(
                                                          '${convertMoney(snapshot.data![index].price)}đ'),
                                                      onTap: () {
                                                        if(hasAccessory==false && servicePick == -1){ Navigator.pop(
                                                            context, ServiceAccessoryList(serviceAccessory:
                                                            snapshot
                                                                .data![index], i: 0));
                                                        }
                                                        setState(() {
                                                          if (servicePick !=
                                                                  index &&
                                                              hasAccessory ==
                                                                  true) {
                                                            servicePick = index;
                                                          } else {
                                                            servicePick = -1;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  );
                                                })
                                            : Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      title: Text(
                                                          '${snapshot.data![servicePick].name}'),
                                                      subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 50),
                                                        child: Text(
                                                          '${snapshot.data![servicePick].description}',
                                                          maxLines: 5,
                                                        ),
                                                      ),
                                                      trailing: Text(
                                                          '${convertMoney(snapshot.data![servicePick].price)}đ'),
                                                      onTap: () {
                                                        setState(() {
                                                          servicePick = -1;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: snapshot
                                                        .data![servicePick]
                                                        .serHasAcc
                                                        ?.length,
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    itemBuilder: (ctx, i) {
                                                      return Card(
                                                        shadowColor:
                                                            Colors.brown,
                                                        surfaceTintColor:
                                                            Colors.tealAccent,
                                                        color: mBackgroundColor
                                                            .withOpacity(0.8),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white54,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .tealAccent,
                                                                Colors.white60
                                                              ],
                                                              begin: Alignment
                                                                  .topRight,
                                                              end: Alignment
                                                                  .bottomLeft,
                                                            ),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context,ServiceAccessoryList(serviceAccessory:
                                                                  snapshot
                                                                      .data![
                                                                          servicePick],i: i)
                                                              );
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Image
                                                                          .asset(
                                                                        checkAccessoryName(snapshot
                                                                            .data![servicePick]
                                                                            .serHasAcc?[i]
                                                                            .accessoryId!
                                                                            .name),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data![servicePick].serHasAcc?[i].accessoryId!.name}',
                                                                        style: const TextStyle(
                                                                            color: Color(
                                                                                0xff0a1034),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            '${convertMoney(snapshot.data![servicePick].serHasAcc?[i].accessoryId!.price)}đ',
                                                                            style:
                                                                                const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
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
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 1.0,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8,
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('Hiện chưa có dịch vụ này'));
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
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
