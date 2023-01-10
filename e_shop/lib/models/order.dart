import 'cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});

  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      amount: json['amount'].toDouble(),
      products: (json['products'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'products': products.map((p) => p.toMap()).toList(),
    };
  }

  Order copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
  }) {
    return Order(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
