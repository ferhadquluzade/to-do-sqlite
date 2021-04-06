import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_scratch/models/task.dart';

class DatabaseHelper {
  DatabaseHelper();
  static final DatabaseHelper instance = DatabaseHelper._instance();
 Database db;
  int colId, colStatus;
  String colName, colDate, colPriority, taskTable;
  DatabaseHelper._instance();
  _initDb() async {
    var dir = await getApplicationDocumentsDirectory() as String;
    var path = dir + "todo.db";
    var toDoTable = await openDatabase(path, version: 1, onCreate: _formDb);
return toDoTable;
  }

  void _formDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $taskTable("$colId AUTOINCREMENT PRIMARYKEY INTEGER,$colName TEXT,$colDate TEXT,$colPriority TEXT,$colStatus INTEGER")');
  }
 List<Task>  taskList=[];
 void getTaskList() async {
Database db=this.db;    
List<Map<String, dynamic>> taskMapList= await db.query(taskTable);

taskMapList.forEach((element) { 
taskList.add(Task.fromMap(element));
});
taskList.sort((task1,task2)=>task1.date.compareTo(task2.date));
}
  List<Task> get_task_list()=> taskList;
insertTask(Task task) async {
Database db=this.db;
final result =await db.insert(taskTable,task.toMap());
return result;    
}
updateTask(Task task,int id) async{
  Database db=this.db;
final result=await db.update(taskTable,task.toMap(),where: "$colId=?", whereArgs: [task.id]);
return result;
}
Future<int> deleteTask(int id)async{
  Database db= this.db;
  final result=await db.delete(taskTable,where: "$colId=?",whereArgs: [id]);
  return result;
}
}
