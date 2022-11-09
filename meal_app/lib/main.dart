import 'package:flutter/material.dart';
import 'package:meal_app/screens/recipe_details_screen.dart';

import 'screens/categories_screen.dart';
import 'screens/category_recipes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
        CategoryRecipesScreen.routeName: (ctx) => CategoryRecipesScreen(),
        RecipeDetailsScreen.routeName: (ctx) => const RecipeDetailsScreen(),
      },
    );
  }
}
