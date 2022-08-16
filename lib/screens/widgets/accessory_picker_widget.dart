import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/models/service_list_data.dart';
import 'package:flutter/material.dart';

class AccessoryPicker extends StatefulWidget {
  final ServiceList items;
  const AccessoryPicker({Key? key, required this.items}) : super(key: key);

  @override
  State<AccessoryPicker> createState() => _AccessoryPickerState();
}

class _AccessoryPickerState extends State<AccessoryPicker> {
  late ServiceHasAcc _serviceValue = widget.items.serviceHasAcc!.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.75,
          child: Container(
            decoration: const BoxDecoration(
                color: mBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    // Initial Value
                    value: _serviceValue,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items:
                        widget.items.serviceHasAcc!.map((ServiceHasAcc items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text('${items.name}',
                              overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (ServiceHasAcc? newValue) {
                      setState(() {
                        _serviceValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text('${_serviceValue.name}'),
                      subtitle: Text('${_serviceValue.description}'),
                      leading: Text(
                        '${_serviceValue.type}',
                      ),
                      trailing: Text('${convertMoney(_serviceValue.price)}đ'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: _serviceValue.accessoriesDetail!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(25),
                  itemBuilder: (ctx, i) {
                    return Card(
                      shadowColor: Colors.brown,
                      surfaceTintColor: Colors.tealAccent,
                      color: mBackgroundColor.withOpacity(0.8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [Colors.tealAccent,Colors.white60],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    checkAccessoryName(_serviceValue
                                        .accessoriesDetail![i].name),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                    '${_serviceValue.accessoriesDetail![i].name}',
                                    style: const TextStyle(
                                        color: Color(0xff0a1034),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    Text(
                                        '${_serviceValue.accessoriesDetail![i].description}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  String checkAccessoryName(name) {
    if (name == 'RAM') {
      return 'assets/images/ram.png';
    } else if (name == 'CPU') {
      return 'assets/images/cpu.png';
    } else if (name == 'Mainboard') {
      return 'assets/images/mainboard.png';
    } else {
      return 'assets/images/white.png';
    }
  }
}
