import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widget/add_card.dart';
import 'package:todo/app/modules/home/widget/add_dialog.dart';
import 'package:todo/app/modules/home/widget/task_cart.dart';
import 'package:todo/onboarding.dart';
import 'package:todo/app/core/utils/extension.dart';
class Home extends GetView<HomeController> {
   Home({Key? key}) : super(key: key);
  final _onBoarding = GetStorage('onBoarding');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.all(4.0.wp),
                  child: Text('My List', style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                IconButton(
                    onPressed: (){
                      _onBoarding.write('onBoarding', true);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=> const Onboarding())
                      );
                    },
                    icon: const Icon(Icons.login, color: Colors.black,))
              ],
            ),
            Obx(()=>GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks.map((element) =>
                    LongPressDraggable(
                      data: element,
                      onDragStarted: ()=>controller.changeDeleting(true),
                      onDraggableCanceled: (_,__)=>controller.changeDeleting(false),
                      onDragEnd: (_)=>controller.changeDeleting(false),
                      feedback: Opacity(
                        opacity: .8,
                        child: TaskCard(task: element),
                      ),
                        child: TaskCard(task: element))).toList(),
                AddCard()
              ],
            ))
          ],
        ),),
      floatingActionButton: DragTarget<Task>(

        builder: (_,__,___){
          return Obx(()=>
              FloatingActionButton(
                backgroundColor: controller.deleteing.value ? Colors.red : Colors.blue,
                onPressed: (){
                  if(controller.tasks.isNotEmpty){
                    Get.to(AddDialog(),transition: Transition.downToUp);
                  }else{
                    EasyLoading.showInfo('Please create a Task Type');
                  }
                },
                child: Icon( controller.deleteing.value ? Icons.delete : Icons.add),
              ),
          );
        },
        onAccept: (Task task){
          print(task);
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Successfull');
        },
      ),
    );
  }
}
