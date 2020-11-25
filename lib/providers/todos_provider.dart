import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/TodoItem.dart';
import 'package:todoApp/util/MenuEnums.dart';
import 'package:http/http.dart' as http;

class Todos with ChangeNotifier {
  static const String serverUrl =
      'https://todoapp-api-vldfm.ondigitalocean.app/';
  String key = '325eec88-d24a-404f-9d3a-db5d51b4fefe';

  List<TodoItem> _items = [];
  MenuFilterOptions _searchParameter;

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

  Future<void> addNewTodoItem(TodoItem todoItem) async {
    var response = await http.post(
      serverUrl + 'todos?key=' + key,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': todoItem.title,
        'done': todoItem.isChecked.toString(),
      }),
    );
    if (response.statusCode == 200) {
      _items = convertToTodoItemList(response);
      notifyListeners();
    }
  }

  Future<void> removeTodo(TodoItem todoItem) async {
    //DELETE /todos/:id?key=[YOUR API KEY]
    //Try to remove it from server, if success -> remove from _items too.
    //no need to reload the whole data.
    String url = serverUrl + 'todos/' + todoItem.id + '?key=' + key;
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        _items.remove(todoItem);
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> changeItemStatus(TodoItem todoItem) async {
    //PUT /todos/:id?key=[YOUR API KEY]
    String url = serverUrl + 'todos/' + todoItem.id + '?key=' + key;
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': todoItem.title,
          'done': (!todoItem.isChecked).toString(),
        }));
    if (response.statusCode == 200) {
      _items.where((element) => element.id == todoItem.id).first.isChecked =
          !todoItem.isChecked;
    }
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

  Future<void> fetchTodos() async {
    try {
      final response = await http.get(serverUrl + 'todos?key=' + key);
      _items = convertToTodoItemList(response);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  static List<dynamic> convertToTodoItemList(dynamic response) {
    final List<TodoItem> loadedList = [];
    json.decode(response.body).forEach((data) => {
          loadedList.add(TodoItem(
              title: data['title'],
              id: data['id'],
              isChecked: data['done'] == 'true'))
        });
    return loadedList;
  }
}
