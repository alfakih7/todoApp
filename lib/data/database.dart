import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];

  // reference the box
  final myBox = Hive.box('mybox');

  //run this methode if this is the first time ever run this app
  void creatInitialData() {
    todoList = [
      ['make tutorial', false],
      ['Do exercise', false],
    ];
  }

  //load the data from the Database
  void loadData() {
    todoList = myBox.get('TODOLIST');
  }

  //update the database
  void updateDataBase() {
    myBox.put('TODOLIST', todoList);
  }
}
