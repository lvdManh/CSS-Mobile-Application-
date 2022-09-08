import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/product_services.dart';
import 'package:computer_service_system/features/service_services.dart';
import 'package:computer_service_system/models/accessory_data.dart';
import 'package:computer_service_system/models/order_detail_data.dart';
import 'package:computer_service_system/models/services_data.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../features/order_services.dart';
import '../../models/computer_type_object.dart';

class AccessoryPicker extends StatefulWidget {
  final String id;
  const AccessoryPicker({Key? key, required this.id}) : super(key: key);

  @override
  State<AccessoryPicker> createState() => _AccessoryPickerState();
}

class _AccessoryPickerState extends State<AccessoryPicker> {
  late bool hasAccessory = false;
  late String typeSer;
  late String selectedComType;
  late List<String> selected = [];
  late List<Service> _serviceToChoose;
  late List<Service> _services;
  late AccessoryMix _accessory;
  String sortTypeCom = 'Tất cả';
  List<String> deviceType = ['Tất cả', 'PC','Laptop','Mac'];
  final OrderDetails _orderDetails = OrderDetails(datas: []);
  List<String> arrange = ['Giá thấp', 'Giá cao', 'Bán chạy'];
  Future<List<Service>> getServiceList(token) async {
    _services = await ServiceServices()
        .fetchServices(token);
    showServicesByFilter();
    return _services;
  }
  Future<AccessoryMix> getAccessoryList(token) async {
    String priceSort = 'asc';
    String isHot;
    if(selectedComType == 'Giá thấp'){
      priceSort = 'Nhỏ nhất';
    }
    if(selectedComType == 'Giá cao'){
      priceSort = 'Lớn nhất';
    }
    if(selectedComType == "Bán chạy"){
      isHot = 'desc';
    }else{
      isHot = 'asc';
    }
    if(sortTypeCom == 'Tất cả'){
      sortTypeCom == '';
    }
    _accessory = await ProductRequest().fetchAccessorySort(token, priceSort,isHot, sortTypeCom, '');
    return _accessory;
  }

  void showServicesByFilter(){
    _serviceToChoose.clear();
    if(typeSer == 'Tất cả'){
      _serviceToChoose.addAll(_services);
    }else {
      _serviceToChoose.addAll(
          _services.where((element) => element.type == typeSer &&
              typeSer != 'Tất cả'));
    }
    if(selectedComType == 'Giá thấp') {
      _serviceToChoose.sort((a, b) => a.price!.compareTo(b.price!));
    }
    if(selectedComType == 'Giá cao') {
      _serviceToChoose.sort((a, b) => b.price!.compareTo(a.price!));
    }
    if(selectedComType == 'Bán chạy') {
      _serviceToChoose.sort((a, b) => b.orderDetailId!.length.compareTo(a.orderDetailId!.length));
    }
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
        textValue = 'Không';
      });
    }
  }


  void sendData(token, id) async {
    setState(() {
      isLoading = true;
    });
    await OrderServices().addDetailOrder(
        context, token, id, _orderDetails);
    setState(() {
      isLoading = false;
    });
  }
  late bool isLoading;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    selectedComType = arrange.first;
    typeSer = typeService.first;
    _serviceToChoose = [];
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      color: Colors.black12.withOpacity(0.3),
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        hasAccessory ? const Text('Linh kiện:'): const Text('Dịch vụ:'),
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
                    !hasAccessory ? Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Row(
                              children: [
                                const Text('Loại: '),
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
                                      showServicesByFilter();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Sắp xếp: '),
                                DropdownButton(
                                  // Initial Value
                                  value: selectedComType,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: arrange.map((String items) {
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
                                      showServicesByFilter();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )): Padding(
                        padding:
                        const EdgeInsets.only(top: 0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Text('Loại: '),
                                DropdownButton(
                                  // Initial Value
                                  value: sortTypeCom,
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
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      sortTypeCom = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Sắp xếp: '),
                                DropdownButton(
                                  // Initial Value
                                  value: selectedComType,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: arrange.map((String items) {
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
                    !hasAccessory ? Expanded(
                          child: FutureBuilder(
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
                                                              maxLines: 2,
                                                                overflow: TextOverflow.ellipsis
                                                            ),
                                                          ),
                                                          trailing: _orderDetails.datas!.any((element) => element.serviceId! == _serviceToChoose[index].id)
                                                              ? Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const Icon(
                                                                      Icons.check,color: Colors.green,size: 28,),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <
                                                                        Widget>[
                                                                      InkWell(
                                                                        child:
                                                                        const Icon(
                                                                          Icons
                                                                              .remove, size: 28,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          if(_orderDetails.datas!.singleWhere((element) => element.serviceId == _serviceToChoose[index].id).amountSer! > 1) {

                                                                            setState(() {
                                                                              _orderDetails
                                                                                .datas!
                                                                                .singleWhere((
                                                                                element) =>
                                                                            element
                                                                                .serviceId ==
                                                                                _serviceToChoose[index]
                                                                                    .id)
                                                                                .amountSer
                                                                            =
                                                                                _orderDetails
                                                                                    .datas!
                                                                                    .singleWhere((
                                                                                    element) =>
                                                                                element
                                                                                    .serviceId ==
                                                                                    _serviceToChoose[index]
                                                                                        .id)
                                                                                    .amountSer! -
                                                                                    1;
                                                                            });
                                                                          }
                                                                        },
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                        '${_orderDetails.datas!.singleWhere((element) => element.serviceId == _serviceToChoose[index].id).amountSer}',style: const TextStyle(fontSize: 18),),
                                                                      const SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      InkWell(
                                                                        child:
                                                                        const Icon(
                                                                          Icons
                                                                              .add, size: 28,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                                  () {
                                                                                    _orderDetails.datas!.singleWhere((element) => element.serviceId == _serviceToChoose[index].id).amountSer
                                                                                        = _orderDetails.datas!.singleWhere((element) => element.serviceId == _serviceToChoose[index].id).amountSer!+1;
                                                                              });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                              : Text(
                                                                  '${convertMoney(_serviceToChoose[index].price)}đ'),
                                                          onTap: () {
                                                            if(_orderDetails.datas!.any((element) => element.serviceId! == _serviceToChoose[index].id)){
                                                              _orderDetails.datas!.removeWhere((element) => element.serviceId == _serviceToChoose[index].id);
                                                            }else {
                                                              _orderDetails.datas!
                                                                  .add(
                                                                  Datas(discount: 0, amountSer: 1,serviceId: _serviceToChoose[index].id));
                                                            }
                                                            setState(() {
                                                              _orderDetails;
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    }),const SizedBox(height: 80,),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text('Trống'),
                                        );
                                }
                              }),
                        ): Expanded(
                      child: FutureBuilder<AccessoryMix>(
                          future: getAccessoryList(token),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: GridView.count(
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 16,
                                  crossAxisCount: 2,
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  children: snapshot.data!.accessories!
                                      .map((Accessories product) {
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
                                            onTap: () {

                                              if(_orderDetails.datas!.any((element) => element.accessoryId == product.id)){
                                                _orderDetails.datas!.removeWhere((element) => element.accessoryId == product.id);
                                              }else {
                                                _orderDetails.datas!
                                                    .add(
                                                    Datas(discount: 0, amountAcc: 1,accessoryId: product.id));
                                              }
                                              setState(() {
                                                _orderDetails;
                                              });
                                            },
                                            child: Stack(children: [
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child:
                                                _orderDetails.datas!.any((element) => element.accessoryId == product.id) ?
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .end,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <
                                                      Widget>[
                                                    InkWell(
                                                      child:
                                                      const Icon(
                                                        Icons
                                                            .remove, size: 20,
                                                      ),
                                                      onTap:
                                                          () {
                                                        if(_orderDetails.datas!.singleWhere((element) => element.accessoryId == product.id).amountAcc! > 1) {

                                                          setState(() {
                                                            _orderDetails
                                                                .datas!
                                                                .singleWhere((
                                                                element) =>
                                                            element
                                                                .accessoryId ==
                                                                product
                                                                    .id)
                                                                .amountAcc
                                                            =
                                                                _orderDetails
                                                                    .datas!
                                                                    .singleWhere((
                                                                    element) =>
                                                                element
                                                                    .accessoryId ==
                                                                    product
                                                                        .id)
                                                                    .amountAcc! -
                                                                    1;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${_orderDetails.datas!.singleWhere((element) => element.accessoryId == product.id).amountAcc}',style: const TextStyle(fontSize: 13),),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      child:
                                                      const Icon(
                                                        Icons
                                                            .add, size: 20,
                                                      ),
                                                      onTap:
                                                          () {
                                                        setState(
                                                                () {
                                                              _orderDetails.datas!.singleWhere((element) => element.accessoryId == product.id).amountAcc
                                                              = _orderDetails.datas!.singleWhere((element) => element.accessoryId == product.id).amountAcc!+1;
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                ):
                                                Text('đ${convertMoney(product.price)}'),
                                              ),
                                              if(_orderDetails.datas!.any((element) => element.accessoryId == product.id)) const Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(Icons.check,color: Colors.green,),
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
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w400)),
                                                  const SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      Text('B/h: ${product.insurance}',
                                                          style: const TextStyle(
                                                              fontSize: 12, fontWeight: FontWeight.w300)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              );
                            }
                          }),
                    ),
                  ]),
                ))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            sendData(token, widget.id);
          },
          icon: const Icon(Icons.add),
          label: Text('Lưu dịch vụ (${_orderDetails.datas!.length})'),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
