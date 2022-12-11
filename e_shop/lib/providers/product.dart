// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../api_routes.dart' as api_routes;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product copyWith(
          {String? id,
          String? title,
          String? description,
          double? price,
          String? imageUrl,
          bool? isFavorite}) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  static Product fromMap(
          String key, Map<String, dynamic> map, bool isFavorite) =>
      Product(
        id: key,
        title: map['title'],
        description: map['description'],
        price: map['price'].toDouble(),
        imageUrl: map['imageUrl'],
        isFavorite: isFavorite,
      );

  Map<String, dynamic> toMap(String userId) => {
        'creatorId': userId,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };

  void _setFavouriteValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldState = isFavorite;
    _setFavouriteValue(!isFavorite);
    final url =
        Uri.https(api_routes.baseUrl, api_routes.addUserFavorite(userId, id), {
      'auth': token,
    });
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode != 200) {
        _setFavouriteValue(oldState);
      }
    } catch (e) {
      _setFavouriteValue(oldState);
      rethrow;
    }
  }
}
