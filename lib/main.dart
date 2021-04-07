import 'package:flutter/material.dart';
import 'package:to_do_scratch/Screens/task_adjust.dart';
import 'package:to_do_scratch/Screens/to_do.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ToDo(),
    );
  }
}
