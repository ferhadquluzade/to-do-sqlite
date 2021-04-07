import "package:flutter/material.dart";
import 'package:to_do_scratch/Screens/task_adjust.dart';
import 'package:to_do_scratch/helper/database_helper.dart';
import 'package:to_do_scratch/models/task.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DatabaseHelper obj = new DatabaseHelper();
  List<Task> task;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      task = DatabaseHelper.instance.get_task_list();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do"),
      ),
      body: task.length == 0
            ? Center(
                child: Text(
                "Add a task",
                style:
                    TextStyle(fontSize:size.width*0.045,fontWeight: FontWeight.w400, color: Colors.black),
              ))
            :  Container(
        child:ListView.builder(
                itemCount: task.length,
                itemBuilder: (BuildContext context, int indx) {
                  return Card(
                      child: ListView(
                    children: [Text("${task[indx]}")],
                  ));
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskAdjustment()));
          }),
    );
  }
}
