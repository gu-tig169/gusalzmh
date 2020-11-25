import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';

class TodosListview extends StatefulWidget {
  const TodosListview({Key key}) : super(key: key);

  @override
  _TodosListviewState createState() => _TodosListviewState();
}

class _TodosListviewState extends State<TodosListview> {
  bool _isLoading = false;
  @override
  void initState() {
    _isLoading = true;
    Provider.of<Todos>(context, listen: false)
        .fetchTodos()
        .then((_) => _isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todosData = Provider.of<Todos>(context);
    var itemList = todosData.todos;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(itemList[index].title),
                background: slideRightBackground(),
                secondaryBackground: slideLeftBackground(),
                confirmDismiss: (DismissDirection direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    todosData.changeItemStatus(itemList[index]);
                    return false;
                  } else if (direction == DismissDirection.endToStart) {
                    todosData.removeTodo(itemList[index]);
                    return true;
                  } else
                    return false;
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
                            todosData.changeItemStatus(itemList[index]);
                          },
                          title: Text(
                            itemList[index].title,
                            style: itemList[index].isChecked
                                ? (TextStyle(
                                    color: Colors.black.withOpacity(0.2),
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic,
                                  ))
                                : (TextStyle()),
                          ),
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

  slideRightBackground() {
    return Container(
        alignment: Alignment.centerLeft,
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ));
  }

  slideLeftBackground() {
    return Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ));
  }
}
