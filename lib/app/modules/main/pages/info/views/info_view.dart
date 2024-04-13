import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:health_app/app/modules/main/pages/history/controllers/history_controller.dart';
import 'package:health_app/app/modules/main/pages/info/controllers/info_controller.dart';
import 'package:health_app/app/modules/main/views/custom_drawer.dart';

class InfoView extends GetView<InfoController> {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(MainController());
    final historyController = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('Product info'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        firstItem: 'Scanned history',
        onLogoutTap: () {
          controller.logout();
        },
        onScanHistoryTap: () {
          historyController.load();
          mainController.pageController.jumpToPage(2);
        },
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.black,))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: controller.errorMessage.value
                        ? Padding(
                          padding: const EdgeInsets.only(top: 200, left: 70, right: 70),
                          child: Column(
                            
                            children: [
                              Image.asset('assets/images/productNo.png', height: 200,width: 200,),
                              const SizedBox(height: 30,),
                             const Text('Product not found :(', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)
                            ],
                          ),
                        ) 
                        : Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                children: controller.listGemini.map((line) {
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
        ),
      ),
    );
  }
}

