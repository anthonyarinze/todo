// ignore_for_file: public_member_api_docs, sort_constructors_first
//This class toggles active/inactive state of tasks in the app

class TodoModel {
  String todoTitle;
  bool completed;
  String location;
  String date;
  TodoModel({
    required this.todoTitle,
    required this.completed,
    required this.date,
    required this.location,
  });

  //to toggle the task
  void toggleCompleted() {
    completed = !completed;
  }
}
