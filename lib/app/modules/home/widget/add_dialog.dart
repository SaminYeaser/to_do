import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeControllelr = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(3.0.wp),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      homeControllelr.editController.clear();
                      homeControllelr.changeTask(null);
                    },
                    icon: Icon(Icons.close)),
                TextButton(
                  onPressed: () {
                    // if(homeControllelr.formKey.currentState!.validate()){
                      if(homeControllelr.task.value == null){
                        EasyLoading.showError('Please select task');
                      }else{
                        var success = homeControllelr.updateTask(
                            homeControllelr.task.value!,
                            homeControllelr.editController.text
                        );
                        if(success){
                          EasyLoading.showSuccess('Task Updated');
                          Get.back();
                          homeControllelr.changeTask(null);
                        }else{
                          EasyLoading.showError('Todo Item is already exist');
                        }
                        homeControllelr.editController.clear();
                      }
                    },
                  // },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                )
              ],
            ),
            Text('New Task',style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold
            ),),
            TextFormField(
              controller: homeControllelr.editController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!
                  ),
                ),
              ),
              autofocus: true,
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Please enter your todo items';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            Text('Add to',style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.grey
            ),),
            SizedBox(height: 10,),
            ...homeControllelr.tasks.map((element) => Obx(()=>InkWell(
              onTap: (){
                homeControllelr.changeTask(element);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(element.icon,color: element.color,),
                        SizedBox(width: 5,),
                        Text('${element.title}',style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    homeControllelr.task.value == element ?
                    const Icon(Icons.check, color: Colors.blue,) : Container()
                  ],
                ),
              ),
            ))
            ).toList()
          ],
        ),
      ),
    );
  }
}
