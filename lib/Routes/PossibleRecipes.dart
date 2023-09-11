import 'dart:convert';
import 'package:app/Components/RecipeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PossibleRecipes extends StatefulWidget {
  PossibleRecipes({Key? key, required this.ingredientList}) : super(key: key);
  List ingredientList = [];

  @override
  State<PossibleRecipes> createState() => _PossibleRecipesState();
}

class _PossibleRecipesState extends State<PossibleRecipes> {
  List<dynamic> possibleRecipes = [];
  List<List<dynamic>> ingredientsList = [];

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/recipes.json');
    final data = await json.decode(response);

    for (int i = 0; i < data.length; i++) {
      int score = 0;

      for (int j = 0; j < data[i]["ingredients"].length; j++) {
        for (int y = 0; y < widget.ingredientList.length; y++) {
          if (data[i]["ingredients"][j] == widget.ingredientList[y]) {
            score++;
          }
        }

        if (score != 0 && score >= data[i]["ingredients"].length) {
          setState(() {
            possibleRecipes.add(data[i]);
          });
        }
      }

      score = 0;
    }

    for (int i = 0; i < possibleRecipes.length; i++) {
      possibleRecipes[i]["index"] = i;
      ingredientsList.add(possibleRecipes[i]["ingredients"]);
    }
  }

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choose your recipe"),
        ),
        body: ListView.builder(
            itemCount: possibleRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              return recipeCard(
                  possibleRecipes[index], context, ingredientsList);
            }));
  }
}
