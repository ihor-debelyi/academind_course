import 'package:flutter/material.dart';

import '../dummy_data.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routeName = '/recipe-details';

  const RecipeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    final recipe = dummyRecipes.firstWhere((recipe) => recipe.id == recipeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Container(
        child: Text(recipe.title),
      ),
    );
  }
}
