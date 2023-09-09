import 'package:app/Routes/PossibleRecipes.dart';
import 'package:flutter/material.dart';

Scaffold selectedOptions(
    List recipeHolder, Function removeIngredient, BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Selected Items"),
    ),
    body: Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: recipeHolder.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(recipeHolder[index]),
                    trailing: IconButton(
                      onPressed: () {
                        removeIngredient(recipeHolder[index]);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PossibleRecipes(ingredientList: recipeHolder),
                  ),
                );
              },
              child: const Text("Get Recipes"),
            ),
          ),
        ),
      ],
    ),
  );
}

