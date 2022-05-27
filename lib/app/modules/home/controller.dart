import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/repository.dart';

class HomeController extends GetxController{
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final editController = TextEditingController();
  @override
  void onInit() {
    tasks.assignAll(taskRepository.readTask()!);
    ever(tasks, (_) => taskRepository.writeTask(tasks));
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  void changeChipIndex(int value){
    chipIndex.value = value;
  }
  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return false;
  }
}