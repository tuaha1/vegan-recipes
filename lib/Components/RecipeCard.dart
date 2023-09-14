import 'package:app/Components/DisplayYoutubeVideos.dart';
import 'package:flutter/material.dart';

Card recipeCard(item, BuildContext context, ingredientList) {
  return Card(
    margin: const EdgeInsets.all(10),
    elevation: 3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item['name'],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Category: " + item["category"]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Meals: " + item["meal"]),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ingredientList[item["index"]].map<Widget>((item) {
                  return Text(
                    item.toString(),
                  );
                }).toList(),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
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
  );
}