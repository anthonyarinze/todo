import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/all_tasks_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _validate = false;
  bool _dateValidate = false;
  bool _timeValidate = false;
  bool _locationValidate = false;
  bool date = false;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.95,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Header Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                  const Text(
                    'New Task',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),

                  //Add task button
                  TextButton(
                    onPressed: () {
                      setState(() {
                        titleController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        locationController.text.isEmpty
                            ? _locationValidate = true
                            : _locationValidate = false;
                        _dateController.text.isEmpty
                            ? _dateValidate = true
                            : _dateValidate = false;
                        _timeController.text.isEmpty
                            ? _timeValidate = true
                            : _timeValidate = false;
                        if (_validate == false &&
                            _locationValidate == false &&
                            _dateValidate == false &&
                            _timeValidate == false) {
                          task.addTask(
                            titleController.text,
                            _dateController.text,
                            locationController.text,
                            _timeController.text,
                          );
                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      });
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),

            //Title and about container
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 4.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  //side: BorderSide(color: Colors.blue),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            errorText:
                                _validate ? "Title can't be empty" : null,
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2.0,
                        height: 2.0,
                        indent: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextField(
                          controller: locationController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Location',
                            errorText: _locationValidate
                                ? "Location can't be empty"
                                : null,
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Date Selector Button
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: Material(
                elevation: 4.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _dateController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      icon: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Icon(Icons.calendar_today_rounded),
                      ),
                      labelText: "Select Date",
                      errorText: _dateValidate ? "Please select a date" : null,
                      border: InputBorder.none,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text = DateFormat('dd MMM yyyy, EEEE')
                              .format(pickedDate);
                        });
                      }
                    },
                  ),
                ),
              ),
            ),

            //Time Picker
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: Material(
                elevation: 4.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _timeController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      icon: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Icon(Icons.calendar_today_rounded),
                      ),
                      labelText: "Select Time",
                      errorText: _timeValidate ? "Please select a time" : null,
                      border: InputBorder.none,
                    ),
                    onTap: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (newTime != null) {
                        setState(() {
                          _timeController.text = newTime.format(context);
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
