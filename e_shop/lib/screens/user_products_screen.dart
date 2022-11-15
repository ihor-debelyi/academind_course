import 'package:e_shop/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import 'package:e_shop/providers/products_provider.dart';
import 'package:flutter/material.dart';

import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<ProductsProvider>(
          builder: (context, products, _) {
            return ListView.builder(
              itemCount: products.items.length,
              itemBuilder: ((_, index) {
                var product = products.items[index];
                return Column(
                  children: [
                    UserProductItem(
                      title: product.title,
                      imageUrl: product.imageUrl,
                    ),
                    const Divider()
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
