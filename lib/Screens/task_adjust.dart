import "package:flutter/material.dart";
import 'package:intl/intl.dart';
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
String _priority="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textCtrl.text = _dateFormat.format(DateTime.now());
  }
List<String> list=["High","Medium","Low"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit,
                          color: Theme.of(context).primaryColor),
                      hintText: "Add a task",
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: "Task",
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
                    TextFormField(
                      onTap: date,
                      controller: textCtrl,
                      readOnly: true,
                    ),
                    DropdownButtonFormField(
                            isDense: true,
                            items:  list.map((String priority) {
                              return DropdownMenuItem(
                                  value: priority,
                                  child: Text(
                                    priority,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ));
                            }).toList(),
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (input) => _priority == null
                                ? "Please Select a priority level"
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _priority = value;
                              });
                            },
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
