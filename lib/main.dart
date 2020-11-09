import 'package:flutter/material.dart';
import 'package:todoApp/DataAccess/todoManager.dart';
import 'package:todoApp/Modules/TodoItem.dart';
import 'package:todoApp/NewTodoRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'To-do main page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ToDoManager todoManager = ToDoManager();
  List<TodoItem> itemList;

  @override
  void initState() {
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
                    case 1:
                      itemList = todoManager.getAllItems();
                      break;
                    case 2:
                      itemList = todoManager.getDoneItems();
                      break;
                    case 3:
                      itemList = todoManager.getUnDoneItems();
                      break;
                    case 4:
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
                      child: Text('Auto'),
                    )
                  ])
        ],
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              Text customizedTitle;
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
                  customizedTitle = new Text(itemList[index].title);
              }
              return Card(
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
                            TodoItem itemToRemove = itemList[index];
                            todoManager.removeTodo(itemToRemove);
                            itemList.remove(itemToRemove);
                          });
                        }),
                      )
                    ],
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

  void _awaitReturnValueFromNewTodoRoute(context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTodoRoute()),
    );
    setState(() {
      if (result != null) todoManager.addNewTodoItem(TodoItem(result));
    });
  }
}
