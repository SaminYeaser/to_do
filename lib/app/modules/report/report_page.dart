import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:intl/intl.dart';
class ReportPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
   ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          var createdTask = homeController.getTotalTask();
          var completedTask = homeController.getTotalDoneTask();
          var liveTask = createdTask - completedTask;
          var percentageWork =(completedTask / createdTask * 100).toStringAsFixed(0);
          return Padding(
            padding:  EdgeInsets.all(8.0.sp),
            child: ListView(
              children: [
                Text('Task Report', style: TextStyle(
                  fontSize: 24.0.sp, fontWeight: FontWeight.bold
                ),),
                Text(DateFormat.yMMMMd().format(DateTime.now()),style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey
                ),),
                SizedBox(height: 5,),
                Divider(thickness: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('$liveTask',style: TextStyle(color: Colors.grey)),
                        ),
                        const Text('Live Tasks'),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('$completedTask',style: TextStyle(color: Colors.grey)),
                        ),
                        const Text('Completed Tasks'),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('$createdTask',style: TextStyle(color: Colors.grey)),
                        ),
                        Text('Created Tasks',),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 50,),
                Center(
                  child: UnconstrainedBox(
                    child: SizedBox(
                      width: 70.0.wp,
                      height: 70.0.wp,
                      child: CircularStepProgressIndicator(
                        totalSteps: createdTask == 0 ? 1: createdTask,
                        currentStep: completedTask,
                        stepSize: 20,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        width: 150,
                          height: 150,
                        selectedStepSize: 22,
                        roundedCap: (_,__)=>true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${createdTask == 0 ? 0 : percentageWork} %',style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 5,),
                            const Text('Efficiency',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}


