import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utile/dialogbox.dart';

import 'utile/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //reference the hive box
  final myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this the first time ever opening te app
    if (myBox.get('TODOLIST') == null) {
      db.creatInitialData();
    } else {
      //there alreadey exist data(nit the first time opening the app)
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final controllerT = TextEditingController();

//checkbox was tapped
  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewtask() {
    setState(() {
      db.todoList.add([
        controllerT.text,
        false,
      ]);
      controllerT.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

//create a new task
  void createnewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controllerT,
            onSave: saveNewtask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deletetask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 213, 127),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TO DO',
          style: TextStyle(),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: db.todoList[index][0],
            tascompleted: db.todoList[index][1],
            onchanged: (value) => checkboxchanged(value, index),
            deleteFunction: (context) => deletetask(index),
          );
        },
      ),
    );
  }
}
