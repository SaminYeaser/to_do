import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=> homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty ? Center(
      child: Container(
          child: Text('No Tasks'),
      ),
    ): Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.0.wp,vertical: 0.0.wp),
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [ ...homeController.doingTodos.map((element) =>
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                value: element['done'],
                onChanged: (value){
                  homeController.doneTodo(
                    element['title']
                  );
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
              child: Text(element['title'],
              overflow: TextOverflow.ellipsis,),
            ),
          ],
        )
        ).toList(),
          if(homeController.doingTodos.isNotEmpty)
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Divider(thickness: 2,),
            )
        ],
      ),
    ));
  }
}
