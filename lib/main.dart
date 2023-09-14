import 'package:flutter/material.dart';
import 'Routes/RecipeList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        appBarTheme: const AppBarTheme(
          color: Colors.green,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const RecipeList(),
    );
  }
}
