import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:to_do_scratch/Screens/to_do.dart';
import 'package:to_do_scratch/helper/database_helper.dart';
import 'package:to_do_scratch/models/task.dart';

class TaskAdjustment extends StatefulWidget {
  Task task;
  TaskAdjustment();
  TaskAdjustment.withTask(this.task);

  @override
  _TaskAdjustmentState createState() => _TaskAdjustmentState();
}

class _TaskAdjustmentState extends State<TaskAdjustment> {
  final textCtrl = TextEditingController();

  var taskCtrl = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');
  date() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != DateTime.now()) {
      setState(() {
        textCtrl.text = _dateFormat.format(date);
      });
    }
  }

  String _priority = "";
  var _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textCtrl.text = _dateFormat.format(DateTime.now());
  }

  List<String> list = ["High", "Medium", "Low"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.15),
                        TextFormField(
                            controller: taskCtrl,
                            validator: (input) =>
                                input == null ? "select a priority" : null,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                              hintText: "Add a task",
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText: "Task",
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )),
                        SizedBox(height: size.height * 0.1),
                        TextFormField(
                          onTap: date,
                          controller: textCtrl,
                          readOnly: true,
                        ),
                        SizedBox(height: size.height * 0.1),
                        DropdownButtonFormField(
                          items: list.map((String priority) {
                            return DropdownMenuItem<String>(
                                value: priority, child: Text(priority));
                          }).toList(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          onChanged: (value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                          validator: (input) =>
                              input == null ? "select a priority" : null,
                        ),
                                                SizedBox(height: size.height * 0.1),

                        ButtonBar(children: [
                            ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                               Navigator.pop(context);
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    Task task = Task(
                                        name: taskCtrl.text,
                                        date: DateTime.parse(textCtrl.text),
                                        priority: _priority,
                                        status: 0);
                                    DatabaseHelper.instance.addTask(task);
                                  }
                                },
                                child: Text("Ok"))
                          ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///without onChanged property dropdown button did not work
///ElevatedButton(raised) has style:ButtonStyle property
