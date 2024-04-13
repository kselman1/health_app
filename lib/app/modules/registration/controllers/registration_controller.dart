import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/app/data/models/user.dart';


class RegistrationController extends GetxController {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final focusNodes=[FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final isLoading=false.obs;

  Future<void> registerUser(String name, String email, String password, String phone) async {
    isLoading.value=true;
  try {
    
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(userCredential);
 
    await _usersCollection.add(MyUser(
      name: name,
      email: email,
      password: password, 
      phone: phone,
    ).toJson());
    isLoading.value=false;
     Get.offAndToNamed('/login');
    
    print('User registered successfully');
  } catch (e) {
    
    print('Error registering user: $e');
  }
}

}
