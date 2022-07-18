import 'package:flutter/material.dart';

import '../../models/appointment.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          print("${item.description} pressed");
        },
        leading: Text(item.id),
        title: Text(item.description,
        ),
        subtitle: Text(item.time),
        trailing: Text(item.status,
          textScaleFactor: 1.1,
          style: TextStyle(
          color: item.status == "Đã hoàn thành" ? Colors.green : Colors.yellow,
            fontWeight: FontWeight.bold,
          ),),
      ),
    );
  }
}


