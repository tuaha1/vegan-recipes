import 'dart:convert';
import 'package:app/Components/RecipeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<dynamic> allPossibleRecipes = [];
List<List<dynamic>> ingredientsList = [];

Future<void> getAllRecipeJsonData() async {
  final String response = await rootBundle.loadString('assets/recipes.json');
  final data = await json.decode(response);

  allPossibleRecipes = [];
  ingredientsList = [];

  for (int i = 0; i < data.length; i++) {
    allPossibleRecipes.add(data[i]);
    allPossibleRecipes[i]["index"] = i;
    ingredientsList.add(allPossibleRecipes[i]["ingredients"]);
  }
}

Scaffold displayAllRecipes(context) {
  getAllRecipeJsonData();

  return Scaffold(
    appBar: AppBar(
      title: const Text("All Recipes"),
    ),
    body: ListView.builder(
      itemCount: allPossibleRecipes.length,
      itemBuilder: (context, index) {
        getAllRecipeJsonData();
        return recipeCard(allPossibleRecipes[index], context, ingredientsList);
      },
    ),
  );
}
