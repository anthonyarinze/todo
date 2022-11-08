import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/all_tasks_provider.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({
    Key? key,
  }) : super(key: key);

  //T0doProvider - the class full of the lists and methods for adding, toggling and deleting tasks.
  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);
    final DateFormat formatter = DateFormat('dd MMM yyyy, EEEE');

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      itemCount: task.incompleteTasks.length,
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
              value: task.incompleteTasks[index].completed,
              onChanged: (value) =>
                  task.toggleTask(task.incompleteTasks[index])),
          //show all the task title
          title: Text(
            task.incompleteTasks[index].todoTitle,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            children: [
              Text(
                task.incompleteTasks[index].time,
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                onPressed: () {
                  //delete task as index item
                  task.deleteTask(task.allTasks[index]);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.incompleteTasks[index].location,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                formatter.format(task.allTasks[index].date),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
