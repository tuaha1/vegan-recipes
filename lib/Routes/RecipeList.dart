import 'package:app/Components/AllRecipes.dart';
import 'package:flutter/material.dart';
import '../Components/ListOptions.dart';
import '../Components/SelectedOptions.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  int _currentIndex = 0;

  List recipeHolder = [
    "black beans",
    "kidney beans",
    "corn",
    "tomato sauce",
    "diced tomatoes",
    "onion",
    "green pepper",
    "chili powder",
  ];

  void listOption(String ingredient) {
    setState(() {
      if (recipeHolder.contains(ingredient)) {
        recipeHolder.remove(ingredient);
      } else {
        recipeHolder.add(ingredient);
      }
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      recipeHolder.remove(ingredient);
    });
  }

  void handleSearchList(List ingredients) {
    setState(() {
      recipeHolder = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      listOptions(listOption, recipeHolder, context, handleSearchList),
      selectedOptions(recipeHolder, removeIngredient, context),
      displayAllRecipes(context)
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'suggestions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'recipes',
          ),
        ],
      ),
    );
  }
}
