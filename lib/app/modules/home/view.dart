import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widget/add_card.dart';
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
                    TaskCard(task: element)).toList(),
                AddCard()
              ],
            ))
          ],
        ),),
    );
  }
}
