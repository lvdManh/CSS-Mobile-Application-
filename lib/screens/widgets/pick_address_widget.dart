import 'package:flutter/material.dart';

class PickAddress extends StatefulWidget {
  final List<String> items;
  final String title;
  const PickAddress({Key? key, required this.items, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
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
        horizontal: 50.0,
        vertical: 200,
      ),
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => ListTile(
            title: Text(item),
            tileColor: _selectedItem==item ? Colors.black12.withOpacity(0.05):Colors.white,
            onTap: () => _itemChange(item),
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