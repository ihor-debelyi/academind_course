import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/models/place_location.dart';

import '../models/place.dart';

class UserPlacesProvider with ChangeNotifier {
  List<Place> _items = [];
  static const String _tableName = 'user_places';

  List<Place> get items => [..._items];

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData(_tableName);
    _items = dataList.map((p) => Place.fromMap(p)).toList();
    notifyListeners();
  }

  Future<Place> getPlaceById(String id) async {
    final place = await DbHelper.getRecord(_tableName, id);
    return Place.fromMap(place);
  }

  Future<void> addPlace(
      String title, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
    final placeLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: placeLocation,
    );
    _items.add(newPlace);
    notifyListeners();

    DbHelper.insert(_tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address ?? "",
    });
  }
}
