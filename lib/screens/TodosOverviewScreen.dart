import 'package:flutter/material.dart';
import 'package:todoApp/util/MenuEnums.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';
import 'package:todoApp/widgets/todos_listview.dart';
import 'NewTodoScreen.dart';

class TodosOverviewScreen extends StatefulWidget {
  TodosOverviewScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodosOverviewScreenState createState() => _TodosOverviewScreenState();
}

class _TodosOverviewScreenState extends State<TodosOverviewScreen> {
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
                  todosData.changeSearchParameter(result);
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
