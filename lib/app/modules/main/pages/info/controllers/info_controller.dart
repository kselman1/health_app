
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:health_app/app/data/sources/shared_pref_source.dart';
import 'package:health_app/app/modules/login/controllers/login_controller.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';

class InfoController extends GetxController {

  final isLoading = false.obs;
  final listGemini=[].obs;
  final response=[].obs;
  final codes=[].obs;
  final product=[].obs;
  final errorMessage=false.obs;
  final homeController=Get.put(HomeController());
   final loginController=Get.put(LoginController());
  
 
  InfoController(){
    load();
  }
  void load() async{
    isLoading.value=true;
   try{
    await getScannedCodes();
   
    await analyzeProductWithGemini();
    
   }catch(e){
    print(e);
   }finally{
    isLoading.value=false;
    
   }
  }

  Future<void> addResponseToScannedCodes(List<String> response) async {
  try {
    CollectionReference scannedCodesCollection =
        FirebaseFirestore.instance.collection('scannedCodes');

    await scannedCodesCollection.doc(loginController.user!.value!.uid).set({
      'response': FieldValue.arrayUnion(response)
    }, SetOptions(merge: true));
    print(response);
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
    }
  } catch (error) {
    print('Error getting scannedCodes data: $error');
  }
}


   Future<void> analyzeProductWithGemini() async {
   // isLoading.value=true;
    //final String categories = proizvod.product['categories'] ?? '';
  final String brands = homeController.proizvod.product['brands'] ?? '';  
    final List<String> keywords =
        List<String>.from(homeController.proizvod.product['_keywords'] ?? []);

    final String brand = brands.isNotEmpty ? brands.split(' ').first : '';
    
   if(codes.contains(homeController.scannedResult)){
    print('ima ga');
    listGemini.value=response;
    return;
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
      if(listGemini.length<200){
        errorMessage.value=true;
      }
      else{
      await addResponseToScannedCodes(listGemini.map((element) => element.toString()).toList());
      }
    }

      print(error);

     
     // isLoading.value=false;
    } catch (e) {
      errorMessage.value=true;
      print("Error analyzing product with Gemini: $e");
    }
  }
  Future<void> logout()async{
    loginController.signOut();
     Get.find<SharedPreferencesSource>().removeAccessToken();
    Get.offAndToNamed('/login');
  }
}
