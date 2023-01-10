import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/models/place_location.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  String get _title => _titleController.text;
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_title.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<UserPlacesProvider>(context, listen: false)
        .addPlace(_title, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Text(
            'User Inputs...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 15),
                    LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            label: const Text('Add Place'),
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: Colors.black,
                backgroundColor: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
