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
  late bool _showSaveFloatButton;
  late bool _showBookingInfo;
  late bool isLoading;
  void checkStatusOrder(status) {
    if (status == 'Hoàn tất hóa đơn') {
      setState(() {
        _showSaveFloatButton = true;
      });
    } else {
      setState(() {
        _showSaveFloatButton = false;
      });
    }
  }

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
    checkStatusOrder(_orderInfo.status);
    return _orderInfo;
  }

  void _showServiceToChoose() async {
    final ServiceAccessoryList results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AccessoryPicker();
      },
    );
    bool checking = false;
    for(var e in servicesListGet){
      if(e.serviceAccessory?.id == results.serviceAccessory?.id){
        checking = true;
      }
    }
    if(checking==false) {
      setState(() {
        servicesListGet.add(results);
      });
    }
  }

  void generateOrderDetails() {
    int count =0;
    _orderDetails.datas!.clear();
    for (var i in servicesListGet) {
      // var checkServiceDup = Datas();
      // checkServiceDup =  _orderDetails.datas!.firstWhere((element) => element.serviceId == i.serviceAccessory!.id, orElse: ()=> Datas());
      if (i.serviceAccessory!.hasAccessory == false) {
        _orderDetails.datas!.add(Datas(
            hasAccessory: false,
            discount: 0,
            serviceId: i.serviceAccessory!.id));
      } else {
        _orderDetails.datas!.add(Datas(
            hasAccessory: true,
            discount: 0,
            serviceId: i.serviceAccessory!.id,
            accessories: [] ));
        for(var e in i.serviceAccessory!.serHasAcc!){
          _orderDetails.datas![count].accessories!.add(AccessoriesQ(accessoryId: e.accessoryId!.id,amountAcc: e.amount));
        }
      }
      count++;
    }
  }

  @override
  void initState() {
    super.initState();
    _showSaveFloatButton = false;
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
      body: SafeArea(
        child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                            const Divider(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Thông tin máy khách",
                                style: TextStyle(
                                    color: mTextColorSecondary,
                                    fontSize: 16,
                                    fontFamily: 'Regular')),
                            InkWell(
                              child: const Icon(
                                Icons.computer,
                                color: Colors.orange,
                              ),
                              onTap: () {
                              },
                            )
                          ],
                        ),
                        const Divider(),
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
                                color: Colors.blue,
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
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Column(
                                  children: [
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
                                    const Divider(),
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10), //border corner radius
                                                      boxShadow:[
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.3), //color of shadow
                                                          spreadRadius: 2, //spread radius
                                                          blurRadius: 2, // blur radius
                                                          offset: const Offset(0, 2), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                          '${servicesListGet[index].serviceAccessory?.name}'),
                                                      subtitle: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Text('Loại: ${servicesListGet[index].serviceAccessory?.type}\nGiá dịch vụ: ${convertMoney(servicesListGet[index].serviceAccessory?.price)}đ'),
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
                                                      onTap: () {
                                                        if(servicesListGet[index].serviceAccessory!.hasAccessory ==true){
                                                          print('1');
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  if(servicesListGet[index].serviceAccessory!.hasAccessory ==true) ListView.builder(
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount: servicesListGet[index].serviceAccessory!.serHasAcc?.length,
                                                      itemBuilder: (context,i){
                                                        return Padding(
                                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                            shadowColor: Colors.blue,
                                                            child: ListTile(
                                                              title: Text(
                                                                  '${servicesListGet[index].serviceAccessory?.serHasAcc?[i].accessoryId?.name}'),
                                                              subtitle: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Đơn giá: ${convertMoney(servicesListGet[index].serviceAccessory?.serHasAcc?[i].accessoryId?.price)}đ'),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                    children: <Widget>[
                                                                      InkWell(
                                                                        child:
                                                                        const Icon(
                                                                          Icons.remove,
                                                                        ),
                                                                        onTap: () {
                                                                          if(servicesListGet[index].serviceAccessory!.serHasAcc![i].amount! > 1){
                                                                            servicesListGet[i].serviceAccessory!.serHasAcc![i].amount
                                                                            = servicesListGet[index].serviceAccessory!.serHasAcc![i].amount! - 1;
                                                                          }
                                                                        },
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                          '${servicesListGet[index].serviceAccessory!.serHasAcc?[i].amount}'),
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
                                                                            servicesListGet[index].serviceAccessory!.serHasAcc![i].amount
                                                                            = servicesListGet[index].serviceAccessory!.serHasAcc![i].amount! + 1;
                                                                          });
                                                                        },
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              trailing: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    servicesListGet[index].serviceAccessory!.serHasAcc!.removeAt(i);
                                                                  });
                                                                },
                                                                child: const Icon(Icons
                                                                    .delete_forever_outlined),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )


                                                ],
                                              ),
                                            );
                                          }),
                                  ],
                                );
                              }
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: _showSaveFloatButton ? FloatingActionButton.extended(
        onPressed: () {
            OrderServices().completeOderByStaff(context, widget.token, widget.order.orderId!.id);
        },
        icon: const Icon(Icons.done_all) ,
        label: const Text('Hoàn thành sửa chữa'),
        backgroundColor: Colors.green,
      ):
        FloatingActionButton.extended(
        onPressed: () {
          generateOrderDetails();
          sendData();
        },
        icon: const Icon(Icons.send) ,
        label: const Text('Lưu dịch vụ'),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
