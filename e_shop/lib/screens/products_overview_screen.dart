import 'package:flutter/material.dart';

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
          )
        ],
      ),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
