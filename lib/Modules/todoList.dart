import 'package:todoApp/Modules/TodoItem.dart';

class TodoList {
  String title;
  List<TodoItem> _items;

  TodoList(String title) {
    this.title = title;
    _items = new List();
  }

  List<TodoItem> getItems() {
    return _items;
  }

  void addNewItem(TodoItem item) {
    _items.add(item);
  }

  void removeItemAtIndex(TodoItem item) {
    _items.remove(item);
  }
}
