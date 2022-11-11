import 'package:flutter/material.dart';

import '../dummy_data.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routeName = '/recipe-details';

  final Function toggleFavorite;
  final Function isRecipeFavorite;

  const RecipeDetailsScreen(this.toggleFavorite, this.isRecipeFavorite,
      {Key? key})
      : super(key: key);

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    final recipe = dummyRecipes.firstWhere((recipe) => recipe.id == recipeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            onPressed: () => toggleFavorite(recipeId),
            icon: isRecipeFavorite(recipeId)
                ? Icon(Icons.star,
                    color: Theme.of(context).colorScheme.secondary)
                : const Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(recipeId);
      //   },
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(recipe.imageUrl, fit: BoxFit.cover),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.ingredients.length,
              itemBuilder: (context, idx) => Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                elevation: 2,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(recipe.ingredients[idx]),
                ),
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.steps.length,
              itemBuilder: (context, idx) => Column(
                children: [
                  ListTile(
                    // leading: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [Text('Step ${idx + 1}')],
                    // ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.black,
                      child: Text('#${idx + 1}'),
                    ),
                    title: Text(
                      recipe.steps[idx],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
