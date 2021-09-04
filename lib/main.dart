import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.green,
      accentColor: Colors.deepPurple,
    ),
    home: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todo = [];
  String input = '';

  @override
  void initState() {
    super.initState();
    todo.add('按 + 可新增');
    todo.add('按筆可編輯');
    todo.add('按垃圾桶可刪除');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add to list'),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (input != '') {
                            todo.add(input);
                          }
                          Navigator.pop(context);
                        });
                      },
                      child: Text('Add'),
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: todo.length,
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
              key: Key(todo[index]),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                    title: Text(todo[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Edit'),
                                      content: TextField(
                                        controller: TextEditingController(
                                          text: todo[index],
                                        ),
                                        onChanged: (String value) {
                                          input = value;
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (input != '') {
                                                todo[index] = input;
                                              }
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Remove'),
                                      content: Text('Do you want to remove ' +
                                          todo[index] +
                                          ' ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              todo.removeAt(index);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          },
                        ),
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
