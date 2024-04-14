import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
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
  final exists=false.obs;
   final response=[].obs;
  final codes=[].obs;
  final product=[].obs;
  final errorMessage=false.obs;
  

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
  void resetVariables(){
    scannedResult.value='';
    brand.value='';
    exists.value=false;
    proizvod=const Product(code: '', product: {});
  }
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
         if (data['status'] == 0) {
        print('Product not found');
       isLoading.value=false;
         mainController.pageController.jumpToPage(1);
        return;
      }
      exists.value=true;
        proizvod = Product(
          code: data['code'] ?? '',
          product: {
            'categories': data['product']['categories'] ?? '',
            'brands': data['product']['brands'] ?? '',
            '_keywords': data['product']['_keywords'] ?? [],
          },
        );
       brand.value = proizvod.product['brands'] ?? '';
       
       
    
       // print('Product: $proizvod');

       

      await getScannedCodes();
      await analyzeProductWithGemini();

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
     Get.offAllNamed('/login');
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
Future<void> addResponseToScannedCodes(List<String> response) async {
  try {
    CollectionReference scannedCodesCollection =
        FirebaseFirestore.instance.collection('scannedCodes');

    await scannedCodesCollection.doc(loginController.user!.value!.uid).set({
      'response': FieldValue.arrayUnion(response)
    }, SetOptions(merge: true));
    print('Response added successfully to scannedCodes collection for user');
  } catch (error) {
    print('Error adding response to scannedCodes collection: $error');
  }
}
Future<void> getScannedCodes() async {
  try {
    CollectionReference scannedCodesCollection =
        FirebaseFirestore.instance.collection('scannedCodes');

    DocumentSnapshot documentSnapshot = await scannedCodesCollection
        .doc(loginController.user!.value!.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
       codes.value = List<String>.from(data['codes'] ?? []);
      product.value = List<String>.from(data['product'] ?? []);
      response.value = List<String>.from(data['response'] ?? []); 
    } else {
      print('No data found for user ${loginController.user!.value!.uid}');
      await addCodeToScannedCodes();
    }
  } catch (error) {
    print('Error getting scannedCodes data: $error');
  }
}
Future<void> analyzeProductWithGemini() async {
   
  if(exists.value==false){
    errorMessage.value=true;
    return;
  }
  final String brands = proizvod.product['brands'] ?? '';  
    final List<String> keywords =
        List<String>.from(proizvod.product['_keywords'] ?? []);

    final String brand = brands.isNotEmpty ? brands.split(' ').first : '';
     
    
   if(codes.contains(scannedResult.value)){
    print('ima ga');
    listGemini.value=response;
    return;
   } else{
    await addCodeToScannedCodes();
   }
    String prompt =
        "What is the health aspect of consuming $brand, $keywords ? What are its nutritional contents like sugar and fat?";


    try {
    
      final gemini = Gemini.instance;

      String error = '';
     /* gemini
          .text(prompt)
          .then((value) => listGemini.value = value!.output!.split('\\n'))
          .catchError((e) => error = e);
      List<String> stringList = listGemini.map((element) => element.toString()).toList();
      */
      final value = await gemini.text(prompt); 
    if (value != null && value.output != null) {
      listGemini.value = value.output!.split('\\n');
     
      await addResponseToScannedCodes(listGemini.map((element) => element.toString()).toList());
      
    }

      print(error);

     
     // isLoading.value=false;
    } catch (e) {
    
      print("Error analyzing product with Gemini: $e");
    }
  }
  

 
}
