import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/all_tasks_provider.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);
    return ListView.separated(
      separatorBuilder: ((context, index) => const SizedBox(height: 15.0)),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      itemCount: task.completeTasks.length,
      itemBuilder: (context, index) => Material(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          //side: BorderSide(color: Colors.blue),
        ),
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 3),

          leading: Checkbox(
              //toggle the task as index item
              value: task.completeTasks[index].completed,
              onChanged: (value) => task.toggleTask(task.completeTasks[index])),
          //show all the task title
          title: Text(
            task.completeTasks[index].todoTitle,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
          trailing: Column(
            children: [
              Text(task.allTasks[index].date),
              IconButton(
                onPressed: () {
                  //delete task as index item
                  task.deleteTask(task.allTasks[index]);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          subtitle: Text(task.completeTasks[index].location),
        ),
      ),
    );
  }
}
