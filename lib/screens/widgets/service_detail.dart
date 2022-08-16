import 'package:computer_service_system/models/services_data.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';

class ServiceDetail extends StatelessWidget {
  final Service service;
  const ServiceDetail({Key? key, required this.service}) : super(key: key);

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
              "Xem dịch vụ",
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
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Thông tin dịch vụ",
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(" Tên dịch vụ:",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        const SizedBox(width: 5),
                        Text(service.name.toString(),
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
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          const Text(" Loại dịch vụ:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          const SizedBox(width: 5),
                          Text(service.type.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Text(" Mô tả:",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                Text(
                  " ${service.description.toString()}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.0),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                const Text(" Linh kiện:",
                    style: TextStyle(
                        // color: mTextColorSecondary,
                        fontSize: 16,
                        fontFamily: 'Regular')),
                const SizedBox(height: 8),
                // if (service.accessoriesId!.isNotEmpty)
                //   ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: service.accessoriesId!.length,
                //     itemBuilder: (context, index) {
                //       return AccessoriesWidget(
                //           product: service.accessoriesId![index]);
                //     },
                //   ),

                // const Text(" Linh kiện:",
                //     style: TextStyle(
                //         // color: mTextColorSecondary,
                //         fontSize: 16,
                //         fontFamily: 'Regular')),
                // const SizedBox(height: 8),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: service.accessoriesId!.length,
                //   itemBuilder: (context, index) {
                //     return AccessoriesWidget(
                //         product: service.accessoriesId![index]);
                //   },
                // ),
              ],
            ),
          ),
        ));
  }
}
