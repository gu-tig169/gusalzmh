import 'package:todoApp/models/TodoItem.dart';

class TestData {
  TestData();

  List<TodoItem> getFakeListOfString() {
    List<TodoItem> _list = List();
    _list.addAll({
      TodoItem('Write a book'),
      TodoItem('Do homework'),
      TodoItem('Tidy room'),
      TodoItem('Nap'),
      TodoItem('Shop groceries'),
      TodoItem('Have fun'),
      TodoItem('Meditate'),
      TodoItem('Write Code'),
    });
    return _list;
  }
}
