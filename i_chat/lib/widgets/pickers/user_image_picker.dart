import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickerFn, {Key? key}) : super(key: key);
  final void Function(File? pickedImage) imagePickerFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 500,
    );
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePickerFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: const Icon(Icons.camera_alt_outlined, size: 20),
        ),
      ]),
    );
  }
}
