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
import '../../models/booking_object.dart';

class AppointmentDetail extends StatelessWidget {
  final Booking bookings;
  const AppointmentDetail({Key? key, required this.bookings}) : super(key: key);


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
            child: Column(
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Text(bookings.cusName.toString(),
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Text(bookings.phonenum.toString(),
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Flexible(
                          child: Text(
                            '${bookings.cusAddress!.street.toString()}, ${bookings.cusAddress!.ward.toString()}, ${bookings.cusAddress!.district.toString()}',
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
                        const Text("Loại máy:",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Text(bookings.type.toString(),
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Flexible(
                          child: Text(
                            bookings.services!.join(', ').toString(),
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Text(parseDate(bookings.time),
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
                        Text("Mô tả tình trạng:",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
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
                          padding: const EdgeInsets.fromLTRB(80, 8, 8, 20),
                        child: Text(
                          bookings.description.toString(),
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
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Text(bookings.status.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Regular')),
                      ],
                    ),
                    const Divider()
                  ],
                ),
                const SizedBox(height: 20),
                if (bookings.status == 'Đang xử lí')
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
                                closeIcon:
                                    const Icon(Icons.close_fullscreen_outlined),
                                title: 'Chắc chắn hủy?',
                                desc: 'Lịch hẹn bị hủy không thể thay đổi',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  BookingServices().cancelBooking(
                                      context, bookings.id, token);
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
                                      builder: (context) => EditAppointment(
                                            bookings: bookings,
                                          )));
                            },
                          ),
                        ),
                      ],
                    ),
                  ) else if(bookings.status =='Đã tiếp nhận' && bookings.orderId!.isNotEmpty)
                  ShowOrder(token: token,orderId: bookings.orderId!,)
                else Container()

              ],
            ),
          ),
        ));
  }
}

class ShowOrder extends StatefulWidget {
  final String token;
  final String orderId;
  const ShowOrder({Key? key,required this.token, required this.orderId}) : super(key: key);

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  bool showWidget = false;
  final OrderServices orderServices = OrderServices();
  Future<Order> getOrder() async{
    return orderServices.getOrderByIdForCus(widget.token, widget.orderId);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        showWidget
            ? FutureBuilder<Order>(
                future: getOrder(),
                builder: (context,snapshot) {
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: <
                      Widget>[
                     Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const Text("Thông tin hóa đơn",
                            style: TextStyle(
                                color: mTextColorSecondary,
                                fontSize: 16,
                                fontFamily: 'Regular')),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Trạng thái hóa đơn:",
                                style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                            Text('${snapshot.data!.status}',
                                style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Ngày tạo:",
                                style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                            Text(parseDate(snapshot.data!.createdAt),
                                style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if(snapshot.data!.orderDetailsId!.isNotEmpty)
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.orderDetailsId!.length,
                              itemBuilder: (context,index) {
                                return snapshot.data!.orderDetailsId![index].accessoriesId == null ? Card(
                                  child: ListTile(
                                    leading: Text('-${snapshot.data!.orderDetailsId![index].discount}%'),
                                    title: Text('${snapshot.data!.orderDetailsId![index].serviceId!.name}'),
                                    subtitle:
                                    Text('Giá dịch vụ: ${snapshot.data!.orderDetailsId![index].serviceId!.price.toString()}'),
                                    trailing: Column(
                                      children: [
                                        const SizedBox(height: 8,),
                                        InkWell(child: Text('x${snapshot.data!.orderDetailsId![index].amountSer.toString()}')),
                                        const SizedBox(height: 8,),
                                         InkWell(child: Text('đ${convertMoney(snapshot.data!.orderDetailsId![index].priceAfter)}')),

                                      ],
                                    ),
                                  ),
                                ) : Card(
                                  child: ListTile(
                                    title: Text('${snapshot.data!.orderDetailsId![index].accessoriesId!.name}'),
                                    subtitle:
                                    Text('Giá dịch vụ: ${snapshot.data!.orderDetailsId![index].accessoriesId!.price.toString()}'),
                                    trailing:
                                    Text('x${snapshot.data!.orderDetailsId![index].amountAcc.toString()}'),
                                  ),
                                );
                              }
                          )
                        else Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Tổng giá:",
                                style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                            Text('${convertMoney(snapshot.data!.totalPrice)}đ',
                                style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  );
                }
            )
            : Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: CustomButton(
                  text: 'Xem hóa đơn',
                  onTap: () {
                    setState(() {
                      showWidget = !showWidget;
                    });
                  },
                ),
              ),
            )
      ],
    );
  }
}


