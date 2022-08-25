

import 'dart:io';

import 'package:computer_service_system/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickScreen extends StatefulWidget {
  const ImagePickScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<ImagePickScreen> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
  final ImagePicker imgPicker = ImagePicker();
  List<XFile>? imageFiles;

  openImages() async {
    try {
      var pickedFiles = await imgPicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedFiles != null){
        imageFiles = pickedFiles;
        setState(() {
        });
      }
    }catch (e) {
      throw Exception(e);
    }
  }

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
              "Chọn ảnh",
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

              //open button ----------------
              ElevatedButton(
                  onPressed: (){
                    openImages();
                  },
                  child: const Text("Chọn ảnh")
              ),

              const Divider(),
              const Text("Ảnh đã chọn:"),
              const Divider(),

              imageFiles != null?Wrap(
                children: imageFiles!.map((imageOne){
                  return Card(
                    child: SizedBox(
                      height: 100, width:100,
                      child: Image.file(File(imageOne.path)),
                    ),
                  );
                }).toList(),
              ):Container()
            ],
          ),
        )
    );
  }
}

