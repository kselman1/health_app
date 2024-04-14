import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

final pageController = PageController();

 
  final page = 0.obs;
  MainController() {
    pageController.addListener(() {
      page.value = pageController.page!.round();
      
    });
  }
}
