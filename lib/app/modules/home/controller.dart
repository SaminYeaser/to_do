import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
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

  void changedTodos(List<dynamic> select){
    doingTodos.clear();
    doneTodos.clear();
    for(int i = 0;i< select.length; i++){
      var todo = select[i];
      var status = todo['done'];
      if(status == true){
        doneTodos.add(todo);
      }else{
        doingTodos.add(todo);
      }
    }
  }

  bool addTodo(String title){
    var todo = {'title':title, 'done':false};
    if(doingTodos.any((element) => mapEquals<String, dynamic>(todo, element))){
      return false;
    }
    var doneTodo = {'title':title, 'done':true};
    if(doneTodos.any((element) => mapEquals<String, dynamic>(todo, element))){
      return false;
    }
    doingTodos.add(todo);
    return true;
  }
  void updateTodos(){
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }
  bool containeTodo(List todos, String title){
    return todos.any((element) => element['title'] == title);
  }
  void doneTodo(String title){
    var doneIndex = {'title': title, 'done':false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doneIndex, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done':true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
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