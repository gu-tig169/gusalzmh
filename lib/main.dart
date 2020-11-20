import 'package:flutter/material.dart';
import 'package:todoApp/screens/TodosOverviewScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodosOverviewScreen(title: 'To-do main page'),
    );
  }
}
