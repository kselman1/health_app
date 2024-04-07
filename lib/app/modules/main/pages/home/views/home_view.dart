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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await controller.scanBarcode();
              },
              child: const Text('Fetch Product Info'),
            ),
            
           
          ],
        ),
      ),
    );
  }
}
