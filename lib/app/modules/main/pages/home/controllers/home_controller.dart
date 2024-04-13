import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:health_app/app/data/models/product.dart';
import 'package:health_app/app/data/sources/shared_pref_source.dart';
import 'package:health_app/app/modules/login/controllers/login_controller.dart';
import 'package:health_app/app/modules/main/controllers/main_controller.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final scannedResult = ''.obs;
  late Product proizvod;
  final isLoading = false.obs;
  final listGemini=[].obs;
  final userName=''.obs;
  final brand=''.obs;
  final mainController=Get.put(MainController());
  final loginController=Get.put(LoginController());
/*
  HomeController(){

    load();
  }
  
  void load() async{
    await getUserName();
  }

  Future<void> getUserName() async {
   isLoading.value=true;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    userName.value = userSnapshot.get('name');
   isLoading.value=false;
    
  }*/

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
    isLoading.value=true;
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
       brand.value = proizvod.product['brands'] ?? '';
       
       
    
        print('Product: $proizvod');

        await addCodeToScannedCodes();
        isLoading.value=false;
       mainController.pageController.jumpToPage(1);
       
       
        
      } else {
        print('Failed product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> logout()async{
    loginController.signOut();
    Get.find<SharedPreferencesSource>().removeAccessToken();
     Get.offAndToNamed('/login');
  }

Future<void> addCodeToScannedCodes() async {
  try {
   
    CollectionReference scannedCodesCollection =
        FirebaseFirestore.instance.collection('scannedCodes');

    await scannedCodesCollection.doc(loginController.user!.value!.uid).set({
      'userId': loginController.user!.value!.uid,
      'codes': FieldValue.arrayUnion([scannedResult.value]),
      'product':FieldValue.arrayUnion([brand.value]),
    }, SetOptions(merge: true));

    print('Code added successfully to scannedCodes collection for user ${loginController.user!.value!.uid}');
  } catch (error) {
    print('Error adding code to scannedCodes collection: $error');
  }
}
  

 
}
