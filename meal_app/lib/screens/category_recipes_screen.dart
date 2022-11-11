// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/recipe_item.dart';

import '../models/recipe.dart';

class CategoryRecipesScreen extends StatefulWidget {
  static const routeName = '/category-recipes';

  final List<Recipe> availableRecipes;
  const CategoryRecipesScreen(
    this.availableRecipes, {
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  String categoryTitle = '';
  List<Recipe> categoryRecipes = [];
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      categoryRecipes = widget.availableRecipes
          .where((recipe) => recipe.categoryIds.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeItem(String id) {
    var recipeToRemove = dummyRecipes.firstWhere((element) => element.id == id);
    setState(() {
      categoryRecipes.remove(recipeToRemove);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          var recipe = categoryRecipes[idx];
          return RecipeItem(
            id: recipe.id,
            title: recipe.title,
            imageUrl: recipe.imageUrl,
            duration: recipe.duration,
            complexity: recipe.complexity,
            affordability: recipe.affordability,
            removeItem: removeItem,
          );
        },
        itemCount: categoryRecipes.length,
      ),
    );
  }
}
