import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/order_services.dart';
import 'package:computer_service_system/models/order_detail_data.dart';
import 'package:computer_service_system/models/order_info_data.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:computer_service_system/models/service_list_data.dart';
import 'package:computer_service_system/screens/widgets/accessory_picker_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';

class StaffViewAppointmentDetailsPage extends StatefulWidget {
  final OrderStaff order;
  final String token;
  const StaffViewAppointmentDetailsPage(
      {Key? key, required this.order, required this.token}) : super(key: key);
  @override
  State<StaffViewAppointmentDetailsPage> createState() =>
      _StaffViewAppointmentDetailsState();
}

class _StaffViewAppointmentDetailsState
    extends State<StaffViewAppointmentDetailsPage> {

  late List<ServiceAccessoryList> servicesListGet = [];
  late final OrderDetails _orderDetails = OrderDetails(datas: []);
  late OrderInfo _orderInfo;
  //late bool _showSaveFloatButton;
  late bool _showBookingInfo;
  late bool isLoading;
  // void checkStatusOrder() {
  //   if (_orderInfo.status == 'Đang chờ' ||
  //       _orderInfo.status == 'Chờ xác nhận') {
  //     setState(() {
  //       _showSaveFloatButton = true;
  //     });
  //   } else {
  //     setState(() {
  //       _showSaveFloatButton = false;
  //     });
  //   }
  // }

  void sendData() {
     OrderServices().addDetailOrder(
        context, widget.token, widget.order.orderId!.id, _orderDetails);
  }
  //  void generateListServiceSaved(){
  //   servicesListGet.clear();
  //   for(var i in _orderInfo.orderDetailsId!){
  //     print(_orderDetails.toJson().toString());
  //     bool hasAcc = false;
  //     if(i.accessories?.first.accessoryId == null){
  //       hasAcc= true;
  //     }
  //     servicesListGet.add(
  //         ServiceAccessoryList(i: 0,
  //             amount: i.accessories!.first.amountAcc,
  //             serviceAccessory: ServiceAccessory(
  //                 hasAccessory: hasAcc,
  //                 id: i.serviceId!.id,
  //                 name: i.serviceId!.name,
  //                 price: i.serviceId!.price,
  //                 serHasAcc: [SerHasAcc(accessoryId: AccessoryId(name: i.accessories!.first.accessoryId?.name,id: i.accessories!.first.accessoryId?.id,
  //                 price: i.accessories!.first.accessoryId?.price))])));
  //   }
  //   setState(() {
  //     servicesListGet;
  //   });
  // }

  Future<OrderInfo> getOrderInfo() async {
    _orderInfo = await OrderServices()
        .getOrderInfoById(widget.token, widget.order.orderId!.id);
    return _orderInfo;
  }

  void _showServiceToChoose() async {
    final ServiceAccessoryList results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AccessoryPicker();
      },
    );
    String check = "";
    for (var i in servicesListGet) {
      if (i.serviceAccessory?.id == results.serviceAccessory?.id &&
          results.serviceAccessory!.hasAccessory != true) {
        check += "service";
      }
      if (results.i != -1 &&
          i.serviceAccessory?.id == results.serviceAccessory?.id) {
        if (i.serviceAccessory!.serHasAcc!.first.id ==
            results.serviceAccessory!.serHasAcc![results.i!].id) {
          check += "accessory";
        }
      }
    }
    if (!check.contains("service") && !check.contains("accessory")) {
      setState(() {
        servicesListGet.add(results);
      });
    }
  }

  void generateOrderDetails() {
    _orderDetails.datas!.clear();
    for (var i in servicesListGet) {
      // var checkServiceDup = Datas();
      // checkServiceDup =  _orderDetails.datas!.firstWhere((element) => element.serviceId == i.serviceAccessory!.id, orElse: ()=> Datas());
      if (i.serviceAccessory!.hasAccessory == false) {
        _orderDetails.datas!.add(Datas(
            hasAccessory: false,
            discount: 5,
            serviceId: i.serviceAccessory!.id));
      } else {
        _orderDetails.datas!.add(Datas(
            hasAccessory: true,
            discount: 5,
            serviceId: i.serviceAccessory!.id,
            accessories: [
              Accessories(
                  accessoryId:
                      i.serviceAccessory!.serHasAcc?[i.i!].accessoryId!.id,
                  amountAcc: i.amount)
            ]));
      }
    }
  }
  @override
  void initState() {
    super.initState();
    //_showSaveFloatButton = true;
    _showBookingInfo = false;
    isLoading = false;
  }

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
            "Lịch hẹn",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration:  const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text("Thông tin khách hàng",
                        style: TextStyle(
                            color: mTextColorSecondary,
                            fontSize: 16,
                            fontFamily: 'Regular')),
                    const SizedBox(height: 8),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Tên khách hàng:",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Regular')),
                            Text('${widget.order.orderId?.bookingId?.cusName}',
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'Regular')),
                          ],
                        ),
                        //const Divider()
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Số điện thoại:",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Regular')),
                            Text('${widget.order.orderId?.bookingId?.phonenum}',
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'Regular')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Địa chỉ:   ",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Regular')),
                            Flexible(
                              child: Text(
                                printAddress(
                                    widget.order.orderId?.bookingId?.cusAddress
                                        ?.street,
                                    widget.order.orderId?.bookingId?.cusAddress
                                        ?.ward,
                                    widget.order.orderId?.bookingId?.cusAddress
                                        ?.district),
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'Regular'),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Thông tin lịch hẹn",
                            style: TextStyle(
                                color: mTextColorSecondary,
                                fontSize: 16,
                                fontFamily: 'Regular')),
                        InkWell(
                          child: const Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            setState(() {
                              _showBookingInfo = !_showBookingInfo;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_showBookingInfo == true)
                      Column(
                        children: [
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text("Thời gian hẹn:",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Regular')),
                                  Flexible(
                                    child: Text(
                                      parseDate(widget
                                          .order.orderId?.bookingId?.time),
                                      style: const TextStyle(
                                          fontSize: 18, fontFamily: 'Regular'),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              //const Divider()
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text("Loại dịch vụ:",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Regular')),
                                  Text(
                                      '${widget.order.orderId?.bookingId?.type}',
                                      style: const TextStyle(
                                          fontSize: 18, fontFamily: 'Regular')),
                                ],
                              ),
                              //const Divider()
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Text("Dịch vụ yêu cầu:",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Regular')),
                                ],
                              ),
                              //const Divider()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // padding:
                            //     const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 8, 8, 20),
                                  child: Text(
                                    '${widget.order.orderId?.bookingId?.services?.join(',\n').toString()}',
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18.0),
                                    maxLines: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Text("Mô tả vấn đề:",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Regular')),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 8, 8, 20),
                                  child: Text(
                                    '${widget.order.orderId?.bookingId?.description}',
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18.0),
                                    maxLines: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text("Chi tiết hóa đơn",
                        style: TextStyle(
                            color: mTextColorSecondary,
                            fontSize: 16,
                            fontFamily: 'Regular')),
                    const SizedBox(height: 8),
                    FutureBuilder(
                        future: getOrderInfo(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              constraints: const BoxConstraints.expand(),
                              child: const CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              children: [
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text("Ngày tạo:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                        Text(parseDate(_orderInfo.createdAt),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text("Cập nhật gần nhất:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                        Text(parseDate(_orderInfo.updatedAt),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text("Trạng thái:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                        Text('${_orderInfo.status}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text("Tổng giá:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                        Text(
                                            '${convertMoney(_orderInfo.totalPrice)}đ',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Regular')),
                                      ],
                                    ),
                                    const Divider()
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Danh sách dịch vụ",
                                        style: TextStyle(
                                            color: mTextColorSecondary,
                                            fontSize: 16,
                                            fontFamily: 'Regular')),
                                    InkWell(
                                      onTap: () {
                                        _showServiceToChoose();
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: Colors.orange,
                                            size: 20,
                                          ),
                                          Text(
                                              'Thêm dịch vụ (${servicesListGet.length})'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (servicesListGet.isNotEmpty)
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: servicesListGet.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                                'Dịch vụ: ${servicesListGet[index].serviceAccessory?.name}'),
                                            subtitle: servicesListGet[index]
                                                        .serviceAccessory
                                                        ?.hasAccessory !=
                                                    true
                                                ? Text(
                                                    'Giá dịch vụ: ${convertMoney(servicesListGet[index].serviceAccessory?.price)}')
                                                : Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Sản phẩm: ${servicesListGet[index].serviceAccessory!.serHasAcc![servicesListGet[index].i!].accessoryId!.name}'),
                                                          Row(
                                                            children: <Widget>[
                                                              InkWell(
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    servicesListGet[
                                                                            index]
                                                                        .amount = servicesListGet[index]
                                                                            .amount! -
                                                                        1;
                                                                  });
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  '${servicesListGet[index].amount}'),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    servicesListGet[
                                                                            index]
                                                                        .amount = servicesListGet[index]
                                                                            .amount! +
                                                                        1;
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Đơn giá: ${convertMoney(servicesListGet[index].serviceAccessory!.serHasAcc![servicesListGet[index].i!].accessoryId!.price)}đ'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            trailing: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  servicesListGet
                                                      .removeAt(index);
                                                });
                                              },
                                              child: const Icon(Icons
                                                  .delete_forever_outlined),
                                            ),
                                          ),
                                        );
                                      }),
                              ],
                            );
                          }
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          generateOrderDetails();
          sendData();
        },
        icon: const Icon(Icons.send) ,
        label: const Text('Lưu'),
        backgroundColor: Colors.orangeAccent,
      // )
      //     :  FloatingActionButton.extended(
      //   onPressed: () {
      //
      //   },
      //   icon: const Icon(Icons.done_all) ,
      //   label: const Text('Hoàn thành sửa chữa'),
      //   backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
