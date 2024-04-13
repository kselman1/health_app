import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:health_app/app/modules/main/pages/history/controllers/history_controller.dart';
import 'package:health_app/app/modules/main/views/custom_drawer.dart';

class HistoryProduct extends GetView<HistoryController> {
  const HistoryProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController=Get.put(MainController());
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
      
        title: const Text('Product info'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        firstItem:'Scanned history',
        onLogoutTap: () {
         controller.logout();
        },
        onScanHistoryTap: () {
          
          mainController.pageController.jumpToPage(2);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.black,),
              color: Colors.white
            ),
            child: Center(
                        child: Column(
                          children: controller.existing.map((line) {
                            
                            String replacedText = line.replaceAll("*", "");
                            return Text(
                              replacedText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
            
                            ),
                            );
                          }).toList(),
                        ),
                      ),
            
            
          ),
        ),
      ),
    );
  }
}
