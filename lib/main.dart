import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/data/service.dart';
import 'package:todo/app/modules/home/binding.dart';
import 'app/modules/home/view.dart';
import 'onboarding.dart';

void main()async {
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  var onBoardingSituation = GetStorage('onBoarding');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      title: 'To Do Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: onBoardingSituation.read('onBoarding') == false ?
       Home() :  const Onboarding(),
      builder: EasyLoading.init(),
    );
  }
}
