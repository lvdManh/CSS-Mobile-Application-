
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
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              const SizedBox(height: 16),
              const Text("Thông tin dịch vụ",
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
                      const Text("Tên",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(service.name.toString(),
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
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
                      const Text("Loại dịch vụ",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(service.type.toString(),
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text("Mô tả:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Text(
                service.description.toString(),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16.0),
                maxLines: 2,),

              const SizedBox(height: 20),

              const Text("Linh kiện:",
                  style: TextStyle(
                      color: mTextColorSecondary,
                      fontSize: 16,
                      fontFamily: 'Regular')),
              const SizedBox(height: 8),
               Text(service.accessoriesId!.length.toString()),

              // ListView.builder(
              //     itemCount: service.accessoriesId!.length,
              //     itemBuilder: (context, index){
              //       return Card(
              //         child: ListTile(
              //           title: Text(service.accessoriesId![index].name.toString()),
              //           trailing: Text(service.accessoriesId![index].description.toString(),
              //             textScaleFactor: 1.1,
              //             style: const TextStyle(
              //               color: Colors.black54,
              //               fontWeight: FontWeight.bold,
              //             ),),
              //         ),
              //       );
              //     },
              //   ),



            ],
            ),

          ),
        )

    );
  }
}
