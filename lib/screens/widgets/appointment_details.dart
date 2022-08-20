import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/features/booking_services.dart';
import 'package:computer_service_system/features/order_services.dart';
import 'package:computer_service_system/models/order_data.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:computer_service_system/screens/widgets/edit_appointment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../constants/utils.dart';
import '../../models/booking_data.dart';
import '../../models/booking_object.dart';

class AppointmentDetail extends StatefulWidget {
  final Booking bookings;
  const AppointmentDetail({Key? key, required this.bookings}) : super(key: key);

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  late Bookings futureBooking;
  late bool isShowDetail = false;
  Future<Bookings> futureBookingByID(token) async {

    if (isShowDetail == false&&futureBooking.status !='Hủy') {
      futureBooking =
          await BookingServices().getOneBookingById(token, widget.bookings.id);
        if(mounted) {
          setState(() {
            futureBooking;
          });
        }
    }
      print('$isShowDetail');
    return futureBooking;
  }


  @override
  void initState() {
    super.initState();
    futureBooking = Bookings(status: '');
  }

  @override
  Widget build(BuildContext context) {
    String token =
        Provider.of<DataClass>(context, listen: false).user.accessToken;
    // String weekday = DateFormat('EEEE').format(dt1);
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<Bookings>(
              future: futureBookingByID(token),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      const Text("Thông tin người hẹn",
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
                              const Text("Tên:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Text(futureBooking.cusName.toString(),
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                            ],
                          ),
                          //const Divider()
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text("Số điện thoại:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Text(futureBooking.phonenum.toString(),
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                                  '${futureBooking.cusAddress!.street.toString()}, ${futureBooking.cusAddress!.ward.toString()}, ${futureBooking.cusAddress!.district.toString()}',
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
                              const Text("Loại:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Text(futureBooking.type.toString(),
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                            ],
                          ),
                          //const Divider()
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text("Dịch vụ yêu cầu:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Flexible(
                                child: Text(
                                  futureBooking.services!.join(', ').toString(),
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
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text("Thời gian hẹn:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Text(parseDate(futureBooking.time),
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                            ],
                          ),
                          //const Divider()
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Text("Mô tả:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // padding:
                        //     const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 0, 10),
                              child: Text(
                                futureBooking.description.toString(),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18.0),
                                maxLines: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text("Trạng thái lịch hẹn:",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Regular')),
                              Text(
                                futureBooking.status.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Regular',
                                    color:
                                        getStatusColor(futureBooking.status)),
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (futureBooking.status == 'Đang xử lí')
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: CustomButton(
                                  text: 'Hủy lịch hẹn',
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      headerAnimationLoop: false,
                                      closeIcon: const Icon(
                                          Icons.close_fullscreen_outlined),
                                      title: 'Chắc chắn hủy?',
                                      desc:
                                          'Lịch hẹn bị hủy không thể thay đổi',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        BookingServices().cancelBooking(
                                            context, futureBooking.id, token);
                                      },
                                    ).show();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: CustomButton(
                                  text: 'Thay đổi lịch hẹn',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditAppointment(
                                                  bookings: futureBooking,
                                                )));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (futureBooking.status == 'Đã tiếp nhận' &&
                          isShowDetail == false)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 150,
                            child: CustomButton(
                              text: 'Xem hóa đơn',
                              onTap: () {
                                setState(() {
                                  isShowDetail = true;
                                });
                              },
                            ),
                          ),
                        )
                        else if(futureBooking.status == "Đã tiếp nhận" && isShowDetail==true)
                          ShowOrder(
                            token: token,
                            orderId: futureBooking.orderId!.id!,
                          )
                      else
                        Container()
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}

class ShowOrder extends StatefulWidget {
  final String token;
  final String orderId;
  const ShowOrder({Key? key, required this.token, required this.orderId})
      : super(key: key);

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  final OrderServices orderServices = OrderServices();
  late Order _order;
  Future<Order> getOrder() async {
    _order =
        await orderServices.getOrderByIdForCus(widget.token, widget.orderId);
    print(_order);
    return _order;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<Order>(
            future: getOrder(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: const [
                          Text("Thông tin hóa đơn",
                              style: TextStyle(
                                  color: mTextColorSecondary,
                                  fontSize: 16,
                                  fontFamily: 'Regular')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Trạng thái hóa đơn:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text('${_order.status}',
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Ngày tạo:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(parseDate(_order.createdAt),
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_order.orderDetailsId!.isNotEmpty)
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _order.orderDetailsId!.length,
                            itemBuilder: (context, index) {
                              return _order.orderDetailsId![index]
                                          .serviceId!.hasAccessory !=true
                                  ? Card(
                                      child: ListTile(
                                        leading: Text(
                                            '-${_order.orderDetailsId![index].discount}%'),
                                        title: Text(
                                            '${_order.orderDetailsId![index].serviceId!.name}'),
                                        subtitle: Text(
                                            'Giá dịch vụ: ${convertMoney(_order.orderDetailsId![index].serviceId!.price)}đ'),
                                        trailing: Column(
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                'x${_order.orderDetailsId![index].amountSer.toString()}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                '${convertMoney(_order.orderDetailsId![index].priceAfter)}đ'),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Card(
                                      child: ListTile(
                                        leading: Text(
                                            '-${_order.orderDetailsId![index].discount}%'),
                                        title: Text(
                                            '${_order.orderDetailsId![index].accessories!.first.accessoryId!.name}'),
                                        subtitle: Text(
                                            'Giá linh kiện: ${convertMoney(snapshot.data!.orderDetailsId![index].accessories!.first.accessoryId!.price)}đ'),
                                        trailing: Column(
                                          children: [
                                            Text(
                                                'x${_order.orderDetailsId![index].accessories!.first.amountAcc.toString()}'),
                                            Text(
                                                '${convertMoney(_order.orderDetailsId![index].priceAfter)}đ'),
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Tổng giá:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text('${convertMoney(_order.totalPrice)}đ',
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      if(_order.status=='Quản lí xác nhận') Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 150,
                          child: CustomButton(
                            text: 'Xác nhận dịch vụ',
                            onTap: () {
                              setState(() {
                                  orderServices.acceptServiceByCus(context, widget.token, widget.orderId);
                              });
                            },
                          ),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              );
            })
      ],
    );
  }
}
