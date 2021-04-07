class Task {
  String priority, name;
  int status, id;
  DateTime date;
  Task({this.name, this.date, this.priority, this.status});
  Task.withId({this.name, this.date, this.id, this.priority, this.status});
   toMap() {
    Map<String, dynamic> taskMap = {};
    taskMap["priority"] = priority;
    taskMap["name"] = name;
    taskMap["date"] = date;
    taskMap["id"]=id;
    return taskMap;
  }

  factory Task.fromMap(Map<String, dynamic> taskMap) {
    return Task.withId(
        priority: taskMap["priority"],
        name: taskMap["name"],
        date: taskMap["date"],
        status: taskMap["status"],
        id: taskMap["id"]);
  }
}
