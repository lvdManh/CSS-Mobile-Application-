import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/models/accessory_data.dart';
import 'package:flutter/material.dart';

class AccessoryDetailScreen extends StatelessWidget {
  final Accessories accessory;
  const AccessoryDetailScreen({Key? key, required this.accessory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: Hero(
            tag: accessory.name!,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                accessory.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: mBackgroundColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 10,),
                Container(
                  height: 300.0,
                  color: Colors.grey[200],
                  child: FadeInImage(
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                      image: NetworkImage(
                        accessory.imgUrl!,
                      ),
                      placeholder:
                      const AssetImage('assets/images/placeholder.png'),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  height: 50.0,
                  child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Chip(
                          labelPadding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          label: Text(accessory.component!,
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                          backgroundColor:
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    accessory.description!,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Loại máy:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          accessory.type!,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: FractionalOffset.centerLeft,
                  child: Wrap(
                    children: <Widget>[
                      const Text(
                        'Bảo hành:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          accessory.insurance!,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Giá: ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '${convertMoney(accessory.price)}đ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}