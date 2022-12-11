import 'package:e_shop/providers/auth_provider.dart';
import 'package:e_shop/providers/cart_provider.dart';
import 'package:e_shop/providers/orders_provider.dart';
import 'package:e_shop/providers/products_provider.dart';
import 'package:e_shop/screens/auth_screen.dart';
import 'package:e_shop/screens/cart_screen.dart';
import 'package:e_shop/screens/edit_product_screen.dart';
import 'package:e_shop/screens/orders_screen.dart';
import 'package:e_shop/screens/product_details_screen.dart';
import 'package:e_shop/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider('', '', []),
          update: (ctx, auth, oldProducts) => ProductsProvider(auth.token ?? '',
              auth.userId ?? '', oldProducts == null ? [] : oldProducts.items),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider('', '', []),
          update: (ctx, auth, oldOrders) => OrdersProvider(auth.token ?? '',
              auth.userId ?? '', oldOrders == null ? [] : oldOrders.orders),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(builder: (context, auth, child) {
        ifAuth(targerScreen) => auth.isAuth ? targerScreen : AuthScreen();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Shop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: Colors.purple,
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
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailsScreen.routeName: (context) =>
                ifAuth(const ProductDetailsScreen()),
            CartScreen.routeName: (context) => ifAuth(CartScreen()),
            OrdersScreen.routeName: (context) => ifAuth(const OrdersScreen()),
            UserProductsScreen.routeName: (context) =>
                ifAuth(const UserProductsScreen()),
            EditProductScreen.routeName: (context) =>
                ifAuth(EditProductScreen()),
            AuthScreen.routeName: (context) => ifAuth(AuthScreen()),
          },
        );
      }),
    );
  }
}
