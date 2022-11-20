import 'package:flutter/material.dart';

import '../data.dart';
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = Data.products;

  List<Product> get items {
    return [..._items]; // return a copy of the list
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  void addProduct(Product product) {
    final productToAdd = product.copyWith(id: DateTime.now().toString());
    _items.add(productToAdd);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
