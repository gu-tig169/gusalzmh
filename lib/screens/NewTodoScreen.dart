import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Interactions for NewToDoRoute where user can add new TodoItem by entering its title.
class NewTodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewTodoScreenState();
}

class NewTodoScreenState extends State<NewTodoScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose(); //displose controller when closing page.
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
                  controller: myController, //controller to get TextField Text.
                  autofocus:
                      true, //get the focus to the textfield as soon as it is visible.
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: "What are you going to do?",
                    border: const OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //Validate text input for empty and blank.
                      myController.text.trim().isEmpty
                          ? _showSnackBar(context)
                          : Navigator.pop(
                              context,
                              myController.text, //pass input back to main.dart
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

  ///Show snackbar to notify user about empty text input.
  void _showSnackBar(context) {
    SnackBar mySnackBar =
        SnackBar(content: Text("Item can't be empty, type something!"));
    Scaffold.of(context).showSnackBar(mySnackBar);
  }
}
