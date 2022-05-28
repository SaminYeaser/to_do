import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/app/core/utils/keys.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/service.dart';

class TaskProvider{
  final StorageServices _storageServices = Get.find<StorageServices>();

  List<Task> readTasks(){
    var tasks = <Task>[];
    jsonDecode(_storageServices.read(taskKey).toString()).forEach((e)=> tasks.add(Task.formJson(e)));
    return tasks;
  }
  void writeTasks(List<Task> tasks){
    _storageServices.write(taskKey, tasks);
  }
}