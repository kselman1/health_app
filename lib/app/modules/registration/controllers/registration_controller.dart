import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/app/data/models/user.dart';


class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> registerUser(String name, String email, String password, String phone) async {
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
     Get.offAndToNamed('/login');
    
    print('User registered successfully');
  } catch (e) {
    
    print('Error registering user: $e');
  }
}

}
