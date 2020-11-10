import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTodoRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewTodoRouteState();
}

class NewTodoRouteState extends State<NewTodoRoute> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TIG169 TODO'),
          actions: [],
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: myController,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: "What are you going to do?",
                    border: const OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      myController.text.trim().isEmpty
                          ? _showSnackBar(context)
                          : Navigator.pop(
                              context,
                              myController.text,
                            );
                    });
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
          );
        }));
  }

  void _showSnackBar(context) {
    SnackBar mySnackBar =
        SnackBar(content: Text("Item can't be empty, type something!"));
    Scaffold.of(context).showSnackBar(mySnackBar);
  }
}
