import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoApp/DataAccess/todoManager.dart';
import 'package:todoApp/models/TodoItem.dart';

import 'NewTodoScreen.dart';

class TodosOverviewScreen extends StatefulWidget {
  TodosOverviewScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodosOverviewScreenState createState() => _TodosOverviewScreenState();
}

class _TodosOverviewScreenState extends State<TodosOverviewScreen> {
  ToDoManager todoManager = ToDoManager();
  List<TodoItem> itemList;

  ///Fetch all todos on first run.
  @override
  void initState() {
    //TODO: remove the following line before deployment. It is merely for test purposes.
    todoManager.generateTestData();

    itemList = todoManager.getAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<int>(
              onSelected: (int result) {
                setState(() {
                  switch (result) {
                    //get the value from popupmenu selection.
                    case 1:
                      itemList = todoManager.getAllItems();
                      break;
                    case 2:
                      itemList = todoManager.getDoneItems();
                      break;
                    case 3:
                      itemList = todoManager.getUnDoneItems();
                      break;
                    case 4: //Change to default?
                      itemList = todoManager.getAllAutoSorted();
                      break;
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem(
                      value: 1,
                      child: Text("All"),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Done'),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text('Undone'),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text('Undone first'),
                    )
                  ])
        ],
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              Text
                  customizedTitle; // To customize the title according to isChecked value.
              switch (itemList[index].isChecked) {
                case true:
                  customizedTitle = new Text(
                    itemList[index].title,
                    style: new TextStyle(
                        color: Colors.black.withOpacity(0.2),
                        decoration: TextDecoration.lineThrough),
                  );
                  break;
                case false:
                  //Title without customization
                  customizedTitle = new Text(itemList[index].title);
              }
              return Dismissible(
                key: Key(itemList[index].title),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    removeItemFromList(index);
                  });
                },
                child: Card(
                  child: Container(
                    padding: new EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        new CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: itemList[index].isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              itemList[index].isChecked = value;
                            });
                          },
                          title: customizedTitle,
                          secondary: CloseButton(onPressed: () {
                            setState(() {
                              removeItemFromList(index);
                            });
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   todoManager.addNewTodoItem(TodoItem("Test From Button"));
          // });
          _awaitReturnValueFromNewTodoRoute(context);
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ///Removes a todoItem from listView source [itemList] and from todoManager.
  void removeItemFromList(int index) {
    //reference to the todoItem-to-be-removed to remove from both lists.
    TodoItem itemToRemove = itemList[index];
    todoManager.removeTodo(itemToRemove);
    itemList.remove(itemToRemove);
  }

  ///Creates a new [TodoItem] and adds it to the todoManager instance if result is not null
  void _awaitReturnValueFromNewTodoRoute(context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTodoScreen()),
    );
    setState(() {
      if (result != null) todoManager.addNewTodoItem(TodoItem(result));
    });
  }
}
