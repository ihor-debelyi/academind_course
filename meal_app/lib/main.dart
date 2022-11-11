import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/recipe_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/filters.dart';
import 'models/recipe.dart';
import 'screens/category_recipes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filters = Filters(
    glutenFree: false,
    lactoseFree: false,
    vegan: false,
    vegetarian: false,
  );

  List<Recipe> _availableRecipes = dummyRecipes;
  List<Recipe> _favoriteRecipes = [];

  void _setFilters(Filters filterData) {
    setState(() {
      _filters = filterData;
      _availableRecipes = dummyRecipes.where((recipe) {
        if (_filters.glutenFree && !recipe.isGlutenFree) {
          return false;
        }
        if (_filters.vegetarian && !recipe.isVegetarian) {
          return false;
        }
        if (_filters.vegan && !recipe.isVegan) {
          return false;
        }
        if (_filters.lactoseFree && !recipe.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String recipeId) {
    final existingIndex =
        _favoriteRecipes.indexWhere((recipe) => recipe.id == recipeId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteRecipes.removeAt(existingIndex);
        Fluttertoast.showToast(
            msg: "Removed from favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      setState(() {
        Recipe recipeToAdd =
            dummyRecipes.firstWhere((recipe) => recipe.id == recipeId);
        _favoriteRecipes.add(recipeToAdd);
        Fluttertoast.showToast(
            msg: "Added to favorites",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }

  bool _isRecipeFavorite(String recipeId) {
    return _favoriteRecipes.any((recipe) => recipe.id == recipeId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
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
        TabsScreen.routeName: (ctx) => TabsScreen(_favoriteRecipes),
        CategoryRecipesScreen.routeName: (ctx) =>
            CategoryRecipesScreen(_availableRecipes),
        RecipeDetailsScreen.routeName: (ctx) =>
            RecipeDetailsScreen(_toggleFavorite, _isRecipeFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
