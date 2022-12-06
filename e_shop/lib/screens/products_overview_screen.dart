import 'package:e_shop/providers/products_provider.dart';
import 'package:e_shop/screens/cart_screen.dart';
import 'package:e_shop/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                _showFavoritesOnly =
                    selectedValue == FilterOptions.Favorites ? true : false;
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                  value: FilterOptions.Favorites,
                  child: Text('Only Favorites')),
              PopupMenuItem(value: FilterOptions.All, child: Text('Show All')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(_showFavoritesOnly),
    );
  }
}
