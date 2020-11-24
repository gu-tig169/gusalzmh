import 'package:todoApp/models/TodoItem.dart';

class TestData {
  TestData();

  List<TodoItem> getFakeListOfString() {
    List<TodoItem> _list = List();
    _list.addAll({
      TodoItem(title: 'Write a book'),
      TodoItem(title: 'Do homework'),
      TodoItem(title: 'Tidy room'),
      TodoItem(title: 'Nap'),
      TodoItem(title: 'Shop groceries'),
      TodoItem(title: 'Have fun'),
      TodoItem(title: 'Meditate'),
      TodoItem(title: 'Write Code'),
    });
    return _list;
  }
}
