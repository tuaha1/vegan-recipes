import 'package:app/Routes/PossibleRecipes.dart';
import 'package:flutter/material.dart';

Scaffold selectedOptions(
    List recipeHolder, Function removeIngredient, BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Selected Ingredients"),
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
                      color: Colors.green,
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
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
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
