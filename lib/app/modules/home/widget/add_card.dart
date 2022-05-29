import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/widget/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcon();
    var squareWidth = Get.width - 12.9.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: SizedBox(
                height: 200,
                child: Form(
                  key: homeController.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                          child: TextFormField(
                            controller: homeController.editController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: 'Title'),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your task title';
                              }
                              return null;
                            },
                          ),
                        ),
                        Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map(
                                (e) => Obx(
                                  () {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeController.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homeController.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              minimumSize: const Size(150, 40)),
                          onPressed: () {
                            if (homeController.formKey.currentState!.validate()) {
                              IconData icon =
                                  icons[homeController.chipIndex.value].icon!;
                              Color color =
                                  icons[homeController.chipIndex.value].color!;
                              var _task = Task(
                                  title: homeController.editController.text,
                                  icon: icon,
                                  color: color);
                              Get.back();
                              print('add task $_task');
                              homeController.addTask(_task)
                                  ? EasyLoading.showSuccess('Task Created')
                                  : EasyLoading.showError('Duplicate Task');
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey,
          dashPattern: [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
