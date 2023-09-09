import 'dart:convert';
import 'package:app/Routes/DisplayYoutubeVideos.dart';
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
      ingredientList.add(possibleRecipes[i]["ingredients"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose your recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: possibleRecipes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 2, crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayYoutubeVideos(
                        title: possibleRecipes[index]["name"],
                        choice:
                            "https://www.youtube.com/results?search_query=" +
                                possibleRecipes[index]["name"]),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.blue[100],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(possibleRecipes[index]["category"]),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.red[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(possibleRecipes[index]["meal"]),
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
                              possibleRecipes[index]["name"],
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: ingredientList[index]
                      //       .map((e) => Text(e.toString()))
                      //       .toList(),
                      // ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.green[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "calories "+possibleRecipes[index]["calories"].toString()
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
