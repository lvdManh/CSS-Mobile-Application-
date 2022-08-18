import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/order_services.dart';
import 'package:computer_service_system/models/order_detail_data.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:computer_service_system/models/service_list_data.dart';
import 'package:computer_service_system/screens/widgets/accessory_picker_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';

class StaffViewAppointmentDetailsPage extends StatefulWidget {
  @override
  State<StaffViewAppointmentDetailsPage> createState() =>
      _StaffViewAppointmentDetailsState();
  final OrderStaff order;
  final String token;
  const StaffViewAppointmentDetailsPage(
      {super.key, required this.order, required this.token});
}

class _StaffViewAppointmentDetailsState
    extends State<StaffViewAppointmentDetailsPage> {
  late List<ServiceAccessoryList> servicesListGet = [];
  late int _currentAmount = 1;
  late final OrderDetails _orderDetails = OrderDetails(datas: []);
  void _showServiceToChoose() async {
    final ServiceAccessoryList results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AccessoryPicker();
      },
    );

    setState(() {
        servicesListGet.add(results);
    });
  }
  void generateOrderDetails(){
    for(var i in servicesListGet){
      if(i.serviceAccessory!.hasAccessory==false){
        _orderDetails.datas!.add(Datas(hasAccessory: false,discount: 5,serviceId: i.serviceAccessory!.id));
      }else{
        _orderDetails.datas!.add(Datas(hasAccessory: true,discount: 5,serviceId: i.serviceAccessory!.id,
            accessories: [Accessories(accessoryId: i.serviceAccessory!.serHasAcc?[i.i!].accessoryId!.id, amountAcc: 1)]
        ));
      }
    }
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
        decoration: const BoxDecoration(
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
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
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
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
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
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Flexible(
                        child: Text(
                          printAddress(
                              widget
                                  .order.orderId?.bookingId?.cusAddress?.street,
                              widget.order.orderId?.bookingId?.cusAddress?.ward,
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
              const Text("Thông tin lịch hẹn",
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
                      const Text("Mã lịch hẹn:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text('${widget.order.orderId?.bookingId?.id}',
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
                      const Text("Thời gian hẹn:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Flexible(
                        child: Text(
                          parseDate(widget.order.orderId?.bookingId?.time),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Loại dịch vụ:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text('${widget.order.orderId?.bookingId?.type}',
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
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
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
                      padding: const EdgeInsets.fromLTRB(80, 8, 8, 20),
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
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 8, 8, 20),
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
              const Divider(),
              const SizedBox(height: 16),
              const Text("Chi tiết hóa đơn",
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
                      const Text("Mã hóa đơn:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text('${widget.order.orderId?.id}',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Ngày tạo:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(parseDate(widget.order.orderId?.createdAt),
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Trạng thái:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text('${widget.order.orderId?.status}',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Tổng giá:",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text('${convertMoney(widget.order.orderId?.totalPrice)}đ',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Danh sách dịch vụ",
                      style: TextStyle(
                          color: mTextColorSecondary,
                          fontSize: 16,
                          fontFamily: 'Regular')),
                  InkWell(
                    onTap: (){ _showServiceToChoose(); },
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: Colors.orange,size: 20,),
                        Text('Thêm dịch vụ (${servicesListGet.length})'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if(servicesListGet.isNotEmpty) ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: servicesListGet.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Dịch vụ: ${servicesListGet[index].serviceAccessory?.name}'),
                        subtitle: servicesListGet[index].serviceAccessory?.hasAccessory != true ? Text(
                            'Giá dịch vụ: ${convertMoney(servicesListGet[index].serviceAccessory?.price)}')
                            : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sản phẩm: ${servicesListGet[index].serviceAccessory!.serHasAcc![servicesListGet[index].i!].accessoryId!.name}'),
                                    Row(
                                      children: <Widget>[
                                        InkWell(
                                          child: const Icon(
                                            Icons.remove,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _currentAmount -= 1;
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 5,),
                                        Text('$_currentAmount'),
                                        const SizedBox(width: 5,),
                                        InkWell(
                                          child: const Icon(
                                            Icons.add,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _currentAmount += 1;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Đơn giá: ${convertMoney(servicesListGet[index].serviceAccessory!.serHasAcc![servicesListGet[index].i!].accessoryId!.price)}đ'),
                                  ],
                                ),
                              ],
                            ),
                        trailing: InkWell(
                          onTap: (){
                            setState(() {
                              servicesListGet.removeAt(index);
                            });
                          },
                          child: const Icon(Icons.delete_forever_outlined),
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              generateOrderDetails();

              OrderServices().addDetailOrder(context, widget.token, widget.order.orderId!.id, _orderDetails);

            },
            icon: const Icon(Icons.send),
            label: const Text('Lưu'),
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
