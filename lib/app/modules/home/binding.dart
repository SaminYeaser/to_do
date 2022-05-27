import 'package:get/get.dart';
import 'package:todo/app/data/providers/tasks/provider.dart';
import 'package:todo/app/data/repository.dart';
import 'package:todo/app/modules/home/controller.dart';

class HomeBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
      taskRepository: TaskRepository(
        taskProvider: TaskProvider()
      )
    ));
  }
}