import 'package:flutter/material.dart';
import 'dart:collection';
import 'todo_model.dart';

class TodoProvider with ChangeNotifier {
  //Dummy tasks
  final List<TodoModel> _tasks = [
    TodoModel(
      todoTitle: 'Buy a house',
      date: '10:00',
      completed: false,
      location: 'Abuja',
    ),
    TodoModel(
      todoTitle: 'Buy a car',
      date: '10:00',
      completed: false,
      location: 'Lagos',
    ),
  ];

  //To get all the tasks
  UnmodifiableListView<TodoModel> get allTasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<TodoModel> get completeTasks =>
      UnmodifiableListView(_tasks.where((element) => element.completed));
  UnmodifiableListView<TodoModel> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((element) => !element.completed));

  //All new added tasks must be uncompleted
  void addTask(String task, DateTime dateTime, String location) {
    _tasks.add(TodoModel(
      todoTitle: task,
      date: dateTime.toString(),
      completed: false,
      location: location,
    ));
    notifyListeners();
  }

  //We are not working with task id that's why we are working with every task index number to modify

  void toggleTask(TodoModel task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTask(TodoModel task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
