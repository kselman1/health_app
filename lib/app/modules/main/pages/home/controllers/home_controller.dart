import 'dart:convert';

import 'package:get/get.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:health_app/app/data/models/product.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final scannedResult = ''.obs;
  late Product proizvod;
  final isLoading = false.obs;
  final listGemini=[].obs;
  final mainController=Get.put(MainController());

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      scannedResult.value = result.rawContent;

      await fetchProductInfo();
    } catch (e) {
      print('Error scanning barcode: $e');
    }
  }

  Future<void> fetchProductInfo() async {
    final String barcode = scannedResult.value;
    final String apiUrl =
        'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // print('Product Info: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);

        proizvod = Product(
          code: data['code'] ?? '',
          product: {
            'categories': data['product']['categories'] ?? '',
            'brands': data['product']['brands'] ?? '',
            '_keywords': data['product']['_keywords'] ?? [],
          },
        );
      
        print('Product: $proizvod');
        mainController.pageController.jumpToPage(1);
        
      } else {
        print('Failed to fetch product information: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product information: $e');
    }
  }

 
}
