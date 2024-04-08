import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/info/controllers/info_controller.dart';

class InfoView extends GetView<InfoController> {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Product info'),
         centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text('Logout'))
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      children: controller.listGemini.map((line) {
                        return Text(line);
                      }).toList(),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
