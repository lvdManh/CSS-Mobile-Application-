import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/order_services.dart';
import 'package:computer_service_system/models/order_info_data.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:computer_service_system/screens/widgets/accessory_picker_widget.dart';
import 'package:computer_service_system/screens/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';

class StaffViewAppointmentDetailsPage extends StatefulWidget {
  final OrderStaff order;
  final String token;
  const StaffViewAppointmentDetailsPage(
      {Key? key, required this.order, required this.token})
      : super(key: key);
  @override
  State<StaffViewAppointmentDetailsPage> createState() =>
      _StaffViewAppointmentDetailsState();
}

class _StaffViewAppointmentDetailsState
    extends State<StaffViewAppointmentDetailsPage> {
  final _submitKey = GlobalKey<FormState>();
  final TextEditingController nameCom = TextEditingController();
  final TextEditingController codeCom = TextEditingController();
  final TextEditingController typeCom = TextEditingController();
  final TextEditingController brandCom = TextEditingController();
  late List<OrderDetailsId> generateOrderDetail = [];
  late OrderInfo _orderInfo;
  late int _showSaveFloatButton;
  late bool _showBookingInfo;
  void checkStatusOrder(status) {
    if (status == 'Hoàn tất hóa đơn') {
      setState(() {
        _showSaveFloatButton = 1;
      });
    } else if (status == 'Hoàn thành') {
      setState(() {
        _showSaveFloatButton = 2;
      });
    } else {
      setState(() {
        _showSaveFloatButton = 0;
      });
    }
  }


  Future<OrderInfo> getOrderInfo() async {
    _orderInfo = await OrderServices()
        .getOrderInfoById(widget.token, widget.order.orderId!.id);
    checkStatusOrder(_orderInfo.status);
    generateOrderDetail = _orderInfo.orderDetailsId!;
    return _orderInfo;
  }

  void _showServiceToChoose() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AccessoryPicker(id: widget.order.orderId!.id!,);
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _showSaveFloatButton = 0;
    _showBookingInfo = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel,color: Colors.red),
              tooltip: 'Hủy lịch hẹn',
              onPressed: () {
                if(_orderInfo.status != "Hoàn thành" && _orderInfo.status != "Hủy") {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.WARNING,
                    title: 'Xác nhận hủy lịch hẹn?',
                    desc: 'Không thể hoàn tác khi đã hủy',
                    btnCancelOnPress: () {
                      OrderServices().cancelOrderByStaff(context, widget
                          .token, widget.order.orderId!.id);
                    },
                    btnCancelText: 'Xác nhận',
                    btnOkText: 'Không',
                    btnOkOnPress: () {},
                  ).show();
                }else{
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.WARNING,
                    title: 'Bạn không thể hủy đơn đã kết thúc',
                    btnOkOnPress: () {},
                  ).show();
                }
              },
            ), //IconButton//IconButton
          ],
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
          decoration: const BoxDecoration(
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
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),

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
                          if (!_orderInfo.checkNullValue()) {
                            nameCom.text = _orderInfo.computerId!.name!;
                            codeCom.text = _orderInfo.computerId!.code!;
                            typeCom.text = _orderInfo.computerId!.type!;
                            brandCom.text = _orderInfo.computerId!.brand!;
                          }
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.NO_HEADER,
                              keyboardAware: true,
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _submitKey,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Nhập thông tin máy',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Material(
                                        elevation: 0,
                                        color: Colors.blueGrey.withAlpha(40),
                                        child: TextFormField(
                                          controller: nameCom,
                                          minLines: 1,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Tên máy',
                                            prefixIcon: Icon(Icons.computer),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Material(
                                        elevation: 0,
                                        color: Colors.blueGrey.withAlpha(40),
                                        child: TextFormField(
                                          controller: codeCom,
                                          keyboardType:
                                          TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Mã máy',
                                            prefixIcon:
                                            Icon(Icons.confirmation_num),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Material(
                                        elevation: 0,
                                        color: Colors.blueGrey.withAlpha(40),
                                        child: TextFormField(
                                          keyboardType:
                                          TextInputType.multiline,
                                          minLines: 1,
                                          controller: typeCom,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Loại máy',
                                            prefixIcon:
                                            Icon(Icons.devices_other),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Material(
                                        elevation: 0,
                                        color: Colors.blueGrey.withAlpha(40),
                                        child: TextFormField(
                                          keyboardType:
                                          TextInputType.multiline,
                                          minLines: 1,
                                          controller: brandCom,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Hãng',
                                            prefixIcon: Icon(Icons.factory),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              btnOkText: "Lưu",
                              btnOkOnPress: () async {
                                if (_submitKey.currentState!.validate() && _orderInfo.status != "Hoàn thành" && _orderInfo.status != "Hủy") {
                                  await OrderServices().addComputerToOrder(
                                      context,
                                      widget.token,
                                      widget.order.orderId!.id,
                                      nameCom.text,
                                      codeCom.text,
                                      typeCom.text,
                                      brandCom.text);
                                }else{
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.SCALE,
                                    dialogType: DialogType.WARNING,
                                    title: 'Đơn đã hoàn thành',
                                    desc: 'Không thể thay đổi',
                                    dismissOnTouchOutside: false,
                                    btnOkOnPress: () { },
                                  ).show();
                                }
                              }).show();
                        },
                      )
                    ],
                  ),

                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Lưu ảnh máy",
                            style: TextStyle(
                                color: mTextColorSecondary,
                                fontSize: 16,
                                fontFamily: 'Regular')),
                        InkWell(
                          child: const Icon(
                            Icons.image,
                            color: Colors.orange,
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ImagePickScreen(id: widget.order.orderId!.id,token: widget.token, imgURL: _orderInfo.imgComUrls,)));
                          },
                        )
                      ]),
                  const Divider(),
                  const SizedBox(height: 8),
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
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Regular',
                                          color: getOrderStatusColor(_orderInfo.status)
                                      )),
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
                                  if(_orderInfo.status != 'Hoàn thành' && _orderInfo.status != 'Hủy') InkWell(
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
                                            'Thêm dịch vụ (${generateOrderDetail.length})'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (generateOrderDetail.isNotEmpty)
                                ListView.builder(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    scrollDirection:
                                    Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: generateOrderDetail.length,
                                    itemBuilder: (context, index) {
                                      return generateOrderDetail[index].amountAcc==0 ? Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            left: 5,
                                            right: 5),
                                        child: Card(
                                          color: Colors.white30.withOpacity(0.9),
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.0),
                                          ),
                                          shadowColor:
                                          Colors.blue,
                                          child: ListTile(
                                            title: Text(
                                                '${generateOrderDetail[index].serviceId!.name}'),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                    'Đơn giá: ${convertMoney(generateOrderDetail[index].serviceId!.price)}đ x ${generateOrderDetail[index].amountSer}'),

                                              ],
                                            ),
                                            trailing: _showSaveFloatButton ==0 ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  OrderServices().removeOrderDetail(context, widget.token, generateOrderDetail[index].id, widget.order.orderId!.id);
                                                });
                                              },
                                              child: const Icon(
                                                  Icons
                                                      .delete_forever_outlined,size: 22),
                                            ):Text(convertMoney(generateOrderDetail[index].priceAfter)),
                                          ),
                                        ),
                                      ): Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            left: 5,
                                            right: 5),
                                        child: Card(
                                          color: Colors.white30.withOpacity(0.9),
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.0),
                                          ),
                                          shadowColor:
                                          Colors.blue,
                                          child: ListTile(
                                            title: Text(
                                                '${generateOrderDetail[index].accessoryId!.name}'),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                    'Đơn giá: ${convertMoney(generateOrderDetail[index].accessoryId!.price)}đ x ${generateOrderDetail[index].amountAcc}'),

                                              ],
                                            ),
                                            trailing: _showSaveFloatButton ==0 ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  OrderServices().removeOrderDetail(context, widget.token, generateOrderDetail[index].id, widget.order.orderId!.id);
                                                });
                                              },
                                              child: const Icon(
                                                  Icons
                                                      .delete_forever_outlined,size: 22),
                                            ) : Text(convertMoney(generateOrderDetail[index].priceAfter)),
                                          ),
                                        ),
                                      );


                                    })
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
      floatingActionButton: _showSaveFloatButton == 1
          ? FloatingActionButton.extended(
              onPressed: () {
                OrderServices().completeOderByStaff(
                    context, widget.token, widget.order.orderId!.id);
              },
              icon: const Icon(Icons.done_all),
              label: const Text('Hoàn thành sửa chữa'),
              backgroundColor: Colors.green,
            )
          :  const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
