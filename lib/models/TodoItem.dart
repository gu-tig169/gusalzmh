import 'package:flutter/cupertino.dart';

///POCO model for one ToDo Item.
class TodoItem {
  String title;
  bool isChecked; //make it private?

  // TodoItem(String title) {
  //   this.title = title;
  //   isChecked = false;
  // }

  TodoItem({
    @required this.title,
    this.isChecked = false,
  });
}
