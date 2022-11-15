// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_shop/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: GridTileBar(
          title: Text(
            '\$${product.price.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: product.toggleFavoriteStatus),
          ),
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Consumer<CartProvider>(
            builder: (ctx, cartProvider, _) => IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  cartProvider.addItem(
                    product.id,
                    product.price,
                    product.title,
                    product.imageUrl,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added ${product.title} to cart!',
                        textAlign: TextAlign.center,
                      ),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cartProvider.removeSingleItem(product.id);
                        },
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }),
          ),
          backgroundColor: Colors.black54,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
