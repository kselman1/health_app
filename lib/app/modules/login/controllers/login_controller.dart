import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/data/sources/shared_pref_source.dart';


class LoginController extends GetxController {

   final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode=FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading=false.obs;

  Rx<User?>? user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user!.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? newUser) {
      user!.value = newUser;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isLoading.value=true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String? token = await currentUser.getIdToken();
         Get.find<SharedPreferencesSource>().setAccessToken(token!);
        print('User Token: $token');
      }
      isLoading.value=false;
      emailController.clear();
      passwordController.clear();
      Get.offAndToNamed('/main');
    } catch (e) {
      isLoading.value=false;
      Get.snackbar('Error', e.toString());
    }
  }


  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
