import 'dart:convert';
import 'package:app/Routes/DisplayYoutubeVideos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PossibleRecipes extends StatefulWidget {
  PossibleRecipes({Key? key, required this.ingredientList}) : super(key: key);
  List ingredientList = [];

  @override
  State<PossibleRecipes> createState() => _PossibleRecipesState();
}

class _PossibleRecipesState extends State<PossibleRecipes> {
  List<dynamic> possibleRecipes = [];
  List<List<dynamic>> ingredientList = [];

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
      ingredientList.add(possibleRecipes[i]["ingredients"]);
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
      body: StaggeredGrid.count(
          crossAxisCount: 2,
          children: possibleRecipes
              .map(
                (item) => Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.lightBlue[100],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item["category"]),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item["meal"]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.green[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['name'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.deepOrange[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: ingredientList[item["index"]]
                                    .map((e) => Text(e.toString()))
                                    .toList()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: const Text("Youtube It"),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplayYoutubeVideos(
                                      title: item["name"],
                                      choice:
                                          "https://www.youtube.com/results?search_query=" +
                                              item["name"]),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
