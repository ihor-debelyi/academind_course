import 'dart:convert';

import 'package:e_shop/api_routes.dart' as api_routes;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/exceptions/http_exception.dart';
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = []; //Data.products;

  List<Product> get items {
    return [..._items]; // return a copy of the list
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.https(api_routes.baseUrl, api_routes.products));
      if (json.decode(response.body) == null) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final fetchedProducts = <Product>[];
      extractedData.forEach((id, productData) {
        fetchedProducts.add(Product.fromMap(id, productData));
      });
      _items = fetchedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(api_routes.baseUrl, api_routes.products);
    try {
      final response = await http.post(
        url,
        body: json.encode(product.toMap()),
      );
      final productToAdd =
          product.copyWith(id: json.decode(response.body)['name']);
      _items.add(productToAdd);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
          Uri.https(api_routes.baseUrl, api_routes.productsUpdate(product.id)),
          body: json.encode(product.toMap()));
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http
        .delete(Uri.https(api_routes.baseUrl, api_routes.productsDelete(id)));
    if (response.statusCode == 200) {
      _items.removeWhere((p) => p.id == id);
    } else {
      throw HttpException('Could not delete product.');
    }
    notifyListeners();
  }
}
