import 'package:todoApp/Modules/TodoItem.dart';
import 'package:todoApp/TestSeed/testData.dart';

class ToDoManager {
  List<TodoItem> _list;
  int id;

  ToDoManager() {
    _list = new List();
  }

  void addNewTodoItem(TodoItem todoItem) {
    _list.add(todoItem);
  }

  void removeTodo(TodoItem todoItem) {
    _list.remove(todoItem);
  }

  List<TodoItem> getAllItems() {
    return _list;
  }

  List<TodoItem> getDoneItems() {
    return _list.where((x) => x.isChecked).toList();
  }

  List<TodoItem> getUnDoneItems() {
    return _list.where((x) => !x.isChecked).toList();
  }

  List<TodoItem> getAllAutoSorted() {
    List<TodoItem> mixed = getUnDoneItems();
    mixed.addAll(getDoneItems());
    return mixed;
  }

  void generateTestData() {
    TestData test = TestData();
    _list.addAll(test.getFakeListOfString());
  }
}
