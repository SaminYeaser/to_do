import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/details/widgets/doing_list.dart';
import 'package:todo/app/modules/home/controller.dart';

class DetailsPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
   DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                    homeController.updateTodos();
                    homeController.changeTask(null);
                    homeController.editController.clear();
                  }, icon: Icon(Icons.arrow_back_ios))
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Row(
                children: [
                  Icon(task?.icon,color: task?.color,),
                  SizedBox(width: 10,),
                  Text('${task?.title}', style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Obx((){
              var totalTodos = homeController.doingTodos.length + homeController.doneTodos.length;
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.0.wp),
                child: Row(
                  children: [
                    Text('$totalTodos Tasks',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0.sp
                    ),),
                    SizedBox(width: 3.0.sp,),
                    Expanded(
                      child: StepProgressIndicator(
                          totalSteps: totalTodos == 0? 1: totalTodos,
                        currentStep: homeController.doneTodos.length,
                        size: 5,
                          padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue.withOpacity(.5), Colors.blue],
                        ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          )
                      ),
                    ),

                  ],
                ),
              );
            }),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: TextFormField(
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Please enter your todo item';
                  }
                  return null;
                },
                controller: homeController.editController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!
                    ),
                  ),
                  prefixIcon: Icon(Icons.check_box_outline_blank,color: Colors.grey[400]!,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(homeController.formKey.currentState!.validate()){
                        var success = homeController.addTodo(
                          homeController.editController.text
                        );
                        if(success){
                          EasyLoading.showSuccess('TODO items selected');
                        }else{
                          EasyLoading.showError('TODO already Exist');
                        }
                        homeController.editController.clear();
                      }
                    },
                    icon: Icon(Icons.done,color: Colors.blueAccent,),
                    color: Colors.grey[400]!,),
                ),
              ),
            ),
            SizedBox(height: 50,),
            DoingList()
          ],
        ),
      ),
    );
  }
}
