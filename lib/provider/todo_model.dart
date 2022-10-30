//This class toggles active/inactive state of tasks in the app

class TodoModel {
  String todoTitle;
  bool completed;
  TodoModel({required this.todoTitle, this.completed = false});

  //to toggle the task
  void toggleCompleted() {
    completed = !completed;
  }
}
