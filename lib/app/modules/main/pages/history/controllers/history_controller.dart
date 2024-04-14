import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:health_app/app/data/sources/shared_pref_source.dart';
import 'package:health_app/app/modules/login/controllers/login_controller.dart';

class HistoryController extends GetxController {

  final loginController=Get.put(LoginController());
  final  codes=[].obs;
  final product=[].obs;
  final isLoading=false.obs;
  final response=[].obs;
  final existing=[].obs;
 
  HistoryController(){
    load();
  }

  void load()async{
    await getScannedCodes();
  }

  Future<void> getScannedCodes() async {
  isLoading.value=true;
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
       print(response);
    } else {
      
      print('No data found for user ${loginController.user!.value!.uid}');
    }
    isLoading.value=false;
  } catch (error) {
    print('Error getting scannedCodes data: $error');
  }
  finally{
    isLoading.value=false;
  }
}
   Future<void> logout()async{
    loginController.signOut();
    Get.find<SharedPreferencesSource>().removeAccessToken();
     Get.offAllNamed('/login');
  }


}
