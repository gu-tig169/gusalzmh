import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoApp/util/MenuEnums.dart';

import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';

import 'NewTodoScreen.dart';

class TodosOverviewScreen extends StatefulWidget {
  TodosOverviewScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodosOverviewScreenState createState() => _TodosOverviewScreenState();
}

class _TodosOverviewScreenState extends State<TodosOverviewScreen> {
  // List<TodoItem> itemList;

  ///Fetch all todos on first run.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todosData = Provider.of<Todos>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<MenuFilterOptions>(
              onSelected: (MenuFilterOptions result) {
                setState(() {
                  switch (result) {
                    //get the value from popupmenu selection.
                    case MenuFilterOptions.ALL:
                      todosData.changeSearchParameter(MenuFilterOptions.ALL);
                      break;
                    case MenuFilterOptions.DONE:
                      todosData.changeSearchParameter(MenuFilterOptions.DONE);
                      break;
                    case MenuFilterOptions.UNDONE:
                      todosData.changeSearchParameter(MenuFilterOptions.UNDONE);
                      break;
                    case MenuFilterOptions.SORTED: //Change to default?
                      todosData.changeSearchParameter(MenuFilterOptions.SORTED);
                      break;
                  }
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuFilterOptions>>[
                    const PopupMenuItem(
                      value: MenuFilterOptions.ALL,
                      child: Text("All"),
                    ),
                    const PopupMenuItem(
                      value: MenuFilterOptions.DONE,
                      child: Text('Done'),
                    ),
                    const PopupMenuItem(
                      value: MenuFilterOptions.UNDONE,
                      child: Text('Undone'),
                    ),
                    const PopupMenuItem(
                      value: MenuFilterOptions.SORTED,
                      child: Text('Undone first'),
                    )
                  ])
        ],
      ),
      body: Center(
        child: TodosListview(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTodoScreen()),
          );
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodosListview extends StatefulWidget {
  const TodosListview({Key key}) : super(key: key);

  @override
  _TodosListviewState createState() => _TodosListviewState();
}

class _TodosListviewState extends State<TodosListview> {
  @override
  Widget build(BuildContext context) {
    final todosData = Provider.of<Todos>(context);
    var itemList = todosData.todos;

    return ListView.builder(
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
              todosData.removeTodo(itemList[index]);
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
                        todosData.changeItemStatus(itemList[index], value);
                      },
                      title: customizedTitle,
                      secondary: CloseButton(onPressed: () {
                        todosData.removeTodo(itemList[index]);
                      }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
