import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.values
      .fold(0, (totalQuantity, element) => totalQuantity + element.quantity);

  double get totalAmount =>
      _items.values.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(String productId, double price, String title, String imageUrl) {
    _items.update(
      productId,
      (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl),
      ifAbsent: () => CartItem(
        id: DateTime.now().toString(),
        title: title,
        quantity: 1,
        price: price,
        imageUrl: imageUrl,
      ),
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
