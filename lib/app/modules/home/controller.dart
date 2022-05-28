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
  final deleteing = false.obs;
  final editController = TextEditingController();
  final task = Rx<Task?>(null);
  @override
  void onInit() {
    tasks.assignAll(taskRepository.readTask()!);
    ever(tasks, (_) => taskRepository.writeTask(tasks));
    super.onInit();
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }
  void changeChipIndex(int value){
    chipIndex.value = value;
  }

  bool updateTask(Task task, String title){
    var todos = task.todos ?? [];
    if(containeTodo(todos, title)){
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }
  bool containeTodo(List todos, String title){
    return todos.any((element) => element['title'] == title);
  }

  void changeTask(Task? select){
    task.value = select;
  }

  void changeDeleting(bool value){
    deleteing.value = value;
  }
  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }
  void deleteTask(Task task){
    tasks.remove(task);
  }
}