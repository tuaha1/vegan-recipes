import 'package:flutter/material.dart';

List selectedIngredients = [];

class SearchIngredients extends StatefulWidget {
  const SearchIngredients(
      {Key? key, required this.ingredientList, required this.searchListHandler, required this.recipeHolder})
      : super(key: key);

  final Map<String, List<dynamic>> ingredientList;
  final void Function(List ingredients) searchListHandler;
  final List recipeHolder;

  @override
  State<SearchIngredients> createState() =>
      _SearchIngredientsState(searchListHandler);
}

class _SearchIngredientsState extends State<SearchIngredients> {
  void Function(List ingredients) searchListHandler;
  _SearchIngredientsState(this.searchListHandler);

  List allIngredients = [];
  List foundIngredients = [];
  List result = [];


  void handleSearch(keyword) {
    if (keyword.toString().isEmpty) {
      setState(() {
        result = allIngredients;
      });
    }

    foundIngredients = allIngredients
        .where((element) => element
            .toString()
            .toLowerCase()
            .contains(keyword.toString().toLowerCase()))
        .toList();

    if (foundIngredients.isNotEmpty) {
      setState(() {
        result = foundIngredients;
      });
    }
  }

  void extractIngredients() {
    for (var element in widget.ingredientList.keys) {
      widget.ingredientList[element]?.forEach((element) {
        allIngredients.add(element);
      });
    }
  }

  @override
  void initState() {
    extractIngredients();
    result = allIngredients;
    selectedIngredients = widget.recipeHolder;
    super.initState();
  }

  void handleClick(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        selectedIngredients.add(ingredient);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for Ingredients"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onChanged: (value) => handleSearch(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter an ingredient name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(result[index]),
                  onChanged: (bool? value) {
                    setState(() {
                      handleClick(result[index]);
                      searchListHandler(selectedIngredients);
                    });
                  },
                  value: selectedIngredients.contains(result[index])
                      ? true
                      : false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
