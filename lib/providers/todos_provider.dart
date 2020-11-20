import 'package:flutter/material.dart';
import '../models/TodoItem.dart';
import '../TestSeed/testData.dart';

class Todos with ChangeNotifier {
  List<TodoItem> _items = [];

  List<TodoItem> get items {
    //wrap with spread operator to get a copy of the list. [..._items]
    return [..._items];
  }

  void addNewTodoItem(TodoItem todoItem) {
    _items.add(todoItem);
    notifyListeners();
  }

  void removeTodo(TodoItem todoItem) {
    _items.remove(todoItem);
    notifyListeners();
  }

  List<TodoItem> get allItems {
    return _items;
  }

  List<TodoItem> get doneItems {
    return _items.where((x) => x.isChecked).toList();
  }

  List<TodoItem> get unDoneItems {
    return _items.where((x) => !x.isChecked).toList();
  }

  ///Method to create a list of all items, sorted by 'Undone' first then 'done'.
  List<TodoItem> get allAutoSorted {
    List<TodoItem> mixed = unDoneItems;
    mixed.addAll(doneItems);
    return mixed;
  }

  ///Method to import generated data for test purposes.
  void generateTestData() {
    TestData test = TestData();
    _items.addAll(test.getFakeListOfString());
    notifyListeners();
  }
}
