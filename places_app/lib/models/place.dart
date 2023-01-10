import 'dart:io';

import 'package:places_app/models/place_location.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  static Place fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      title: map['title'],
      image: File(map['image']),
      location: PlaceLocation(
        latitude: map['loc_lat'],
        longitude: map['loc_lng'],
        address: map['address'],
      ),
    );
  }
}
