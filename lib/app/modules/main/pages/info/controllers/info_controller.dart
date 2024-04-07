import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';

class InfoController extends GetxController {

  final isLoading = false.obs;
  final listGemini=[].obs;
  final homeController=Get.put(HomeController());

  InfoController(){
    load();
  }
  void load() async{
    isLoading.value=true;
   try{
    await analyzeProductWithGemini();
    isLoading.value=false;
   }catch(e){
    print(e);
   }finally{
    isLoading.value=false;
   }
  }
   Future<void> analyzeProductWithGemini() async {
    //final String categories = proizvod.product['categories'] ?? '';
    final String brands = homeController.proizvod.product['brands'] ?? '';
    final List<String> keywords =
        List<String>.from(homeController.proizvod.product['_keywords'] ?? []);

    final String brand = brands.isNotEmpty ? brands.split(' ').first : '';

    String prompt =
        "What is the health aspect of consuming $brand, $keywords ? What are its nutritional contents like sugar and fat?";


    try {
    
      final gemini = Gemini.instance;

      String error = '';
      gemini
          .text(prompt)
          .then((value) => listGemini.value = value!.output!.split('\\n'))
          .catchError((e) => error = e);
  
      print(error);

      for (String line in listGemini) {
        print(line);
      }
      
    } catch (e) {
      print("Error analyzing product with Gemini: $e");
    } 
  }
}
