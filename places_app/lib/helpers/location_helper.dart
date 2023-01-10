import 'dart:convert';

import 'package:http/http.dart' as http;

const String googleApiKey = 'AIzaSyBMDW_cdMOgfjWwu8BlUaehA8ZieV_mcAc';
const String googleMapsSignature = '4zE5BSYxtfCn0d7S1RY73IU2Xys=';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude%2c%$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
