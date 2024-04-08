import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text('Logout'))
        ],
      ),
      body: Center(
        child: Obx(() {
          return controller.isLoading.value
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await controller.scanBarcode();
                  },
                  child: const Text('Fetch Product Info'),
                );
        }),
      ),
    );
  }
}
