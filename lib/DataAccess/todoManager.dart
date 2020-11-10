import 'package:todoApp/Modules/TodoItem.dart';
import 'package:todoApp/TestSeed/testData.dart';

///This class works as a holder for the todoList and has methods to CRUD items.
class ToDoManager {
  List<TodoItem> _list;

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

  ///Method to create a list of all items, sorted by 'Undone' first then 'done'.
  List<TodoItem> getAllAutoSorted() {
    List<TodoItem> mixed = getUnDoneItems();
    mixed.addAll(getDoneItems());
    return mixed;
  }

  ///Method to import generated data for test purposes.
  void generateTestData() {
    TestData test = TestData();
    _list.addAll(test.getFakeListOfString());
  }
}
