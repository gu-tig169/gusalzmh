import 'package:flutter/material.dart';
import '../models/TodoItem.dart';
import '../TestSeed/testData.dart';
import 'package:todoApp/util/MenuEnums.dart';

class Todos with ChangeNotifier {
  List<TodoItem> _items = [];
  MenuFilterOptions _searchParameter;

  Todos() {
    TestData test = TestData();
    _items.addAll(test.getFakeListOfString());
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
    //wrap with spread operator to get a copy of the list. [..._items]
    return [..._items];
  }

  List<TodoItem> get doneItems {
    return [..._items].where((x) => x.isChecked).toList();
  }

  List<TodoItem> get unDoneItems {
    return [..._items].where((x) => !x.isChecked).toList();
  }

  ///Method to create a list of all items, sorted by 'Undone' first then 'done'.
  List<TodoItem> get allAutoSorted {
    List<TodoItem> mixed = unDoneItems;
    mixed.addAll(doneItems);
    return mixed;
  }

  void changeItemStatus(TodoItem todoItem, bool value) {
    _items[_items.indexOf(todoItem)].isChecked = value;
    notifyListeners();
  }

  void changeSearchParameter(MenuFilterOptions searchParameter) {
    _searchParameter = searchParameter;
    notifyListeners();
  }

  List<TodoItem> get todos {
    switch (_searchParameter) {
      case MenuFilterOptions.ALL:
        return allItems;
        break;
      case MenuFilterOptions.DONE:
        return doneItems;
        break;
      case MenuFilterOptions.UNDONE:
        return unDoneItems;
        break;
      case MenuFilterOptions.SORTED:
        return allAutoSorted;
        break;
      default:
        return allItems;
        break;
    }
  }
}
