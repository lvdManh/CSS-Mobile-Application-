import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/models/order_staff_data.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';

class StaffViewAppointmentDetailsPage extends StatefulWidget {
  @override
  State<StaffViewAppointmentDetailsPage> createState() =>
      _StaffViewAppointmentDetailsState();

  final OrderStaff order;

  const StaffViewAppointmentDetailsPage({super.key, required this.order});
}

class _StaffViewAppointmentDetailsState
    extends State<StaffViewAppointmentDetailsPage> {
  int _selectedItemIndex = 1;

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
                            printAddress(widget.order.orderId?.bookingId?.cusAddress?.street,
                                widget.order.orderId?.bookingId?.cusAddress?.ward,
                                widget.order.orderId?.bookingId?.cusAddress?.district),
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
                        const Text("Id lịch hẹn:",
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
                          child: Text(parseDate(widget.order.orderId?.bookingId?.time),
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
                        child: Text('${widget.order.orderId?.bookingId?.services?.join(',\n').toString()}',
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
                        child: Text('${widget.order.orderId?.bookingId?.description}',
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
                    //const Divider()
                  ],
                ),

              ],
            ),
          ),
        ));
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}
