import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  bool _validate = false;
  bool date = false;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    detailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.95,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                  TextButton(
                    onPressed: () {
                      setState(() {
                        titleController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
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
                  height: 300,
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
                        height: 2.0,
                        thickness: 2.0,
                        indent: 15.0,
                        endIndent: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextField(
                          controller: detailsController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'About',
                            hintStyle: TextStyle(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  //side: BorderSide(color: Colors.blue),
                ),
                child: ExpansionTile(
                  leading: const Icon(Icons.calendar_month_rounded,
                      color: Colors.red),
                  title: const Text('Date'),
                  trailing: Switch(
                      value: date,
                      onChanged: ((value) => setState(() async {
                            date = value;
                            if (date == true) {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2100));
                              print(pickedDate);
                            }
                          }))),
                  children: const [
                    Divider(
                      thickness: 2.0,
                      height: 1.0,
                      indent: 70.0,
                    ),
                    // Container(
                    //   height: 480,
                    //   decoration: const BoxDecoration(
                    //       color: Colors.transparent,
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(20.0))),
                    //   child: DatePickerDialog(
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(1990),
                    //       lastDate: DateTime(2100)),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
