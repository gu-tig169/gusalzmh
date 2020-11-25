import 'package:flutter/cupertino.dart';

///POCO model for one ToDo Item.
class TodoItem {
  String title;
  bool isChecked; //make it private?
  String id;

  TodoItem({@required this.title, this.isChecked = false, this.id});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
        title: json['title'], id: json['id'], isChecked: json['done']);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "done": isChecked.toString(),
        'id': id,
      };
}
