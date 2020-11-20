///POCO model for one ToDo Item.
class TodoItem {
  String title;
  bool isChecked; //make it private?

  TodoItem(String title) {
    this.title = title;
    isChecked = false;
  }
}
