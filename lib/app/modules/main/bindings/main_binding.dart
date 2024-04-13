import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/history/controllers/history_controller.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';
import 'package:health_app/app/modules/main/pages/info/controllers/info_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
     Get.lazyPut<HomeController>(() => HomeController());
     Get.lazyPut<InfoController>(() => InfoController());
     Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
