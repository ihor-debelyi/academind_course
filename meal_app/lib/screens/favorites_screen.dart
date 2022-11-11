import 'package:flutter/material.dart';
import 'package:meal_app/widgets/recipe_item.dart';

import '../models/recipe.dart';

class FavoritesScreen extends StatelessWidget {
  List<Recipe> favoriteRecipes;
  FavoritesScreen(this.favoriteRecipes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteRecipes.isEmpty
        ? const Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, idx) {
              Recipe recipe = favoriteRecipes[idx];
              return RecipeItem(
                id: recipe.id,
                title: recipe.title,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                complexity: recipe.complexity,
                affordability: recipe.affordability,
              );
            },
          );
  }
}
