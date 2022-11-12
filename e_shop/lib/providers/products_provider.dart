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
    _items.add(product);
    notifyListeners();
  }
}
