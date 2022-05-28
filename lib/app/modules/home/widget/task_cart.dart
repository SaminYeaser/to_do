import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/app/modules/details/view.dart';
import 'package:todo/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  TaskCard({Key? key, required this.task}) : super(key: key);
  final homeController = Get.find<HomeController>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.wp;
    final color = task.color;
    return GestureDetector(
      onTap: (){
        homeController.changeTask(task);
        homeController.changedTodos(task.todos ?? []);
        Get.to(DetailsPage());
      },
      child: Container(
        height: squareWidth / 2,
        width: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [task.color!.withOpacity(.5), task.color!],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(6.0.wp),
              child: Icon(task.icon, color: task.color,),
            ),
            Padding(
              padding:  EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title!, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp
                  ),),
                  SizedBox(height: 2.0.wp,),
                  Text('${task.todos?.length ?? 0} Tasks', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 12.0.sp
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
