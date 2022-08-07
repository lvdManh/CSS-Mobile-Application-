import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/models/services_data.dart';
import 'package:computer_service_system/screens/widgets/service_detail.dart';
import 'package:flutter/material.dart';

import '../features/service_services.dart';

class ServicesScreen extends StatefulWidget {
  static const String routeName = '/services-screen';
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<Service>> futureService;

  @override
  void initState() {
    super.initState();
    futureService = ServiceServices().fetchServices();
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
            "Dịch vụ",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<List<Service>>(
                future: futureService,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  'Dịch vụ: ${snapshot.data![index].name}'),
                              subtitle: Text(
                                  'Mô tả: ${snapshot.data![index].description.toString()}'),
                              trailing: Text(
                                  '${snapshot.data?[index].type.toString()}'),
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServiceDetail(
                                              service: snapshot.data![index],
                                            )));
                              },
                            ),
                          );
                        });
                  }
                })),
      ),
    );
  }
}
