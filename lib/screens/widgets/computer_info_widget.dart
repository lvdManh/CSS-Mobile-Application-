import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/models/order_data.dart';
import 'package:flutter/material.dart';

class ComputerInfoScreen extends StatefulWidget {
  const ComputerInfoScreen({Key? key, this.computer, this.imgURL}) : super(key: key);
  final Computer? computer;
  final List<String>? imgURL;

  @override
  State<ComputerInfoScreen> createState() => _ComputerInfoScreenState();
}

class _ComputerInfoScreenState extends State<ComputerInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Thông tin máy",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        color: mBackgroundColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Thông tin máy",
                style: TextStyle(
                    color: mTextColorSecondary,
                    fontSize: 16,
                    fontFamily: 'Regular')),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Tên máy:",
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Regular')),
                widget.computer?.name != null ? Text('${widget.computer?.name}',
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'Regular')): const Text(''),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Mã máy:",
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Regular')),
                widget.computer?.code != null ?Text('${widget.computer?.code}',
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'Regular')): const Text(''),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Loại máy:",
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Regular')),
                widget.computer?.type != null ? Text('${widget.computer?.type}',
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'Regular')): const Text(''),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Hãng máy:",
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Regular')),
                widget.computer?.brand != null ? Text('${widget.computer?.brand}',
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'Regular')) : const Text(''),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Hình ảnh:"),
            const SizedBox(height: 10),
            widget.imgURL != null ? Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: widget.imgURL!.map((imageOne) {
                    return Card(
                      child: Container(
                        constraints: const BoxConstraints.tightFor(
                          height: 320,
                          width: 180,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageOne),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: InkWell(
                                child: const Text(''),
                                onTap: () {
                                },
                              ))
                        ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ) : Container(),
            const Divider(),
            //open button ----------------
          ],
        ),
      ),
    );
  }
}
