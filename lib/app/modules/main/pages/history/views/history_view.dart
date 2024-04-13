import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:health_app/app/modules/main/views/custom_drawer.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
 
  @override
  Widget build(BuildContext context) {
     final mainController=Get.put(MainController());
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Scanned history'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        firstItem:'Home',
        onLogoutTap: () {
          controller.logout();
        },
        onScanHistoryTap: () {
          mainController.pageController.jumpToPage(0);
         
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.black,))
              : ListView.builder(
                itemCount: controller.codes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      controller.existing.value=[controller.response[index]];
                  
                      mainController.pageController.jumpToPage(3);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(width: 2, color: Colors.black)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                            Text(controller.codes[index], 
                            style: const TextStyle(fontWeight: FontWeight.w600),),
                            Text(controller.product[index], 
                            style: const TextStyle(fontWeight: FontWeight.w600),),
                           ],
                          ),
                        ),
                        
                        const SizedBox(height: 15,)
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
