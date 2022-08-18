import 'package:computer_service_system/models/service_list_data.dart';
import 'package:flutter/material.dart';

class PickService extends StatefulWidget {
  final List<ServiceAccessory> items;
  final String title;
  const PickService({Key? key, required this.items, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickServiceState();
}

class _PickServiceState extends State<PickService> {
  // this variable holds the selected items
  String _selectedItem = '';
// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue) {
    setState(() {
      _selectedItem = itemValue;
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 100,
      ),
      title: Text(widget.title),
      content: SingleChildScrollView(
        child:
            ListBody(
              children: widget.items
                  .map((item) => Card(
                child: ListTile(
                  title: Text('${item.name}'),
                  tileColor: _selectedItem==item.name ? Colors.black12.withOpacity(0.1):Colors.white,
                  onTap: () => _itemChange(item.name!),
                ),
              ))
                  .toList(),
            ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}