import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/info/controllers/info_controller.dart';

class InfoView extends GetView<InfoController> {

  
  const InfoView( {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product info'),
      ),
      body: SingleChildScrollView(
        child:controller.isLoading.value? const Center(child:  CircularProgressIndicator()): Center(
          child: Obx(
            () {
             
                return Column(
                  children: controller.listGemini.map((line) {
                    return Text(line);
                  }).toList(),
                );
              
            },
          ),
        ),
      ),
    );
  }
}
