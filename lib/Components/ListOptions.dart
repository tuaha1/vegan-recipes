import 'package:app/Data/Ingredients.dart';
import 'package:flutter/material.dart';
import '../Data/Ingredients.dart';

DefaultTabController listOptions(
    void Function(String ingredient) listOption, addedList) {
  List<Tab> myTabs = ingredients.keys.map((key) {
    return Tab(text: key);
  }).toList();

  return DefaultTabController(
    length: myTabs.length,
    child: Scaffold(
      appBar: AppBar(
        title: const Text("What's on my fridge"),
        bottom: TabBar(tabs: myTabs),
      ),
      body: TabBarView(
        children: ingredients.keys.map((e) {
          return ListView.builder(
              itemCount: ingredients[e]?.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(ingredients[e]![index]),
                  value:
                      addedList.contains(ingredients[e]![index]) ? true : false,
                  onChanged: (value) {
                    listOption(ingredients[e]![index]);
                  },
                );
              });
        }).toList(),
      ),
    ),
  );
}
