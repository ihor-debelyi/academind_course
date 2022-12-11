// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_shop/api_routes.dart' as api;

import '../models/exceptions/http_exception.dart';
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  ProductsProvider(
    this.authToken,
    this.userId,
    this._items,
  );

  List<Product> _items = [];

  List<Product> get items {
    return [..._items]; // return a copy of the list
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    try {
      final queryParameters = filterByUser
          ? {
              'auth': authToken,
              'orderBy': '"creatorId"',
              'equalTo': '"$userId"',
            }
          : {'auth': authToken};
      var url = Uri.https(api.baseUrl, api.getProducts, queryParameters);
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return;
      }
      url = Uri.https(
          api.baseUrl, api.getUserFavorites(userId), {'auth': authToken});
      final favoritesResponse = await http.get(url);
      final favoriteData = json.decode(favoritesResponse.body);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final fetchedProducts = <Product>[];
      extractedData.forEach((id, productData) {
        fetchedProducts.add(Product.fromMap(id, productData,
            favoriteData == null ? false : favoriteData[id] ?? false));
      });
      _items = fetchedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(api.baseUrl, api.getProducts, {'auth': authToken});
    try {
      final response = await http.post(
        url,
        body: json.encode(product.toMap(userId)),
      );
      final productToAdd =
          product.copyWith(id: json.decode(response.body)['name']);
      _items.add(productToAdd);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final url = Uri.https(
        api.baseUrl,
        api.productsUpdate(product.id),
        {
          'auth': authToken,
        },
      );
      await http.patch(url, body: json.encode(product.toMap(userId)));
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        Uri.https(api.baseUrl, api.productsDelete(id), {'auth': authToken});
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      _items.removeWhere((p) => p.id == id);
    } else {
      throw HttpException('Could not delete product.');
    }
    notifyListeners();
  }
}
