// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/recipe_item.dart';

class CategoryRecipesScreen extends StatelessWidget {
  static const routeName = '/category-recipes';
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryRecipesScreen({
  //   Key? key,
  //   required this.categoryId,
  //   required this.categoryTitle,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryRecipes = dummyRecipes
        .where((recipe) => recipe.categoryIds.contains(categoryId))
        .toList();
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
          );
        },
        itemCount: categoryRecipes.length,
      ),
    );
  }
}
