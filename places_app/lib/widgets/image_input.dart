// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageInput extends StatefulWidget {
  final Function(File) onSelectImage;

  ImageInput({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    var imagePicker = ImagePicker();
    final pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedFile == null) {
      return;
    }
    final imageFile = File(pickedFile.path);
    setState(() {
      _storedImage = imageFile;
    });
    final fileName = path.basename(imageFile.path);
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 20),
        Expanded(
            child: TextButton.icon(
          onPressed: _takePicture,
          label: const Text('Take picture'),
          icon: const Icon(Icons.camera),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
          ),
        ))
      ],
    );
  }
}
