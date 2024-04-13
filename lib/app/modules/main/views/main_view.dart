
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/history/views/history_product.dart';
import 'package:health_app/app/modules/main/pages/history/views/history_view.dart';
import 'package:health_app/app/modules/main/pages/home/views/home_view.dart';
import 'package:health_app/app/modules/main/pages/info/views/info_view.dart';

import '../controllers/main_controller.dart';


class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: WillPopScope(
        onWillPop: () async {
          if (controller.page.value == 0) {
            return true;
          } else {
            controller.pageController.jumpToPage(0);

            return false;
          }
        },
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            InfoView(),
            HistoryView(),
            HistoryProduct()
           
          ],
        ),
      ),
    );
  }
}
