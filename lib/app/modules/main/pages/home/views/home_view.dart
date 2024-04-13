import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/login/views/custom_button.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';
import 'package:health_app/app/modules/main/views/custom_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController=Get.put(MainController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
       
      ),
      drawer: CustomDrawer(
        onScanHistoryTap: () {
          mainController.pageController.jumpToPage(2);
        },
        onLogoutTap: () {
          controller.logout();
        }, 
        firstItem: 'Scanned history',
      ),
      body: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.black),
          image: const DecorationImage(
            image: AssetImage('assets/images/home333.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Did you know?\nSome foods like celery, apples, and strawberries require more calories to digest than they contain, making them great choices for snacking when you are watching your calorie intake!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : CustomButton(() async {
                          await controller.scanBarcode();
                        }, Colors.black, Colors.yellow, text: 'Scan & Fetch');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
