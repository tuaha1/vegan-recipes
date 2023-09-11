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

  List<String> recipeHolder = [
    "black beans",
    "kidney beans",
    "corn",
    "tomato sauce",
    "diced tomatoes",
    "onion",
    "green pepper",
    "chili powder",
    "cooked rice",
    "pineapple chunks",
    "tofu",
    "bell peppers",
    "carrots",
    "peas",
    "garlic",
    "soy sauce",
    "curry powder",
    "sriracha",
    "sesame oil",
    "salt",
    "tortillas",
    "mushrooms",
    "spinach",
    "red onion",
    "nutritional yeast",
    "garlic powder",
    "cumin",
    "paprika",
    "pepper",
    "guacamole (for serving)"
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      listOptions(listOption, recipeHolder),
      selectedOptions(recipeHolder, removeIngredient, context),
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
        ],
      ),
    );
  }
}