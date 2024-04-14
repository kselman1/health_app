
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
  
  @override
  void onClose(){
    resetVariables();
    super.dispose();
  }
 /*
  InfoController(){
    load();
  }
  void load() async{
    isLoading.value=true;
   try{
    await getScannedCodes();
    
   }catch(e){
    print(e);
   }finally{
    isLoading.value=false;
    
   }
  }
  */
  void resetVariables(){
    listGemini.value=[];
    response.value=[];
    codes.value=[];
    product.value=[];
  }
  



   
  Future<void> logout()async{
    loginController.signOut();
     Get.find<SharedPreferencesSource>().removeAccessToken();
    Get.offAndToNamed('/login');
  }
}
