import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAndToNamed('/main');
    } catch (e) {
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
