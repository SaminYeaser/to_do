import 'package:todo/app/data/providers/tasks/provider.dart';

import 'models/task.dart';

class TaskRepository{
  TaskProvider? taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task>? readTask()=> taskProvider?.readTasks();
  void writeTask(List<Task> tasks)=> taskProvider?.writeTasks(tasks);

}