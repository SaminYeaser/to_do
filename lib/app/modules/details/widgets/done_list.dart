import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    homeController.doneTodos.isNotEmpty ? Padding(
      padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Text('Completed Task (${homeController.doneTodos.length})'),
          ...homeController.doneTodos.map((element) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_)=>homeController.deleteDoneTodo(element),
            background: Container(
              color: Colors.red.withOpacity(.8),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete,color: Colors.white,),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    Icons.done,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
                  child: Text(element['title'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                ),
              ],
            ),
          )
          ).toList()
        ],
      ),
    ): Container());
  }
}
