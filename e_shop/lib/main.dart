import 'package:e_shop/providers/products_provider.dart';
import 'package:e_shop/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: Colors.deepOrange,
              ),
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          ProductsOverviewScreen.routeName: (context) =>
              ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (context) =>
              const ProductDetailsScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Text(
          'You have pushed the button this many times:',
        ),
      ),
    );
  }
}
