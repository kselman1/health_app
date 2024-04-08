import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSubmitted: (_) async {
                 await controller.signInWithEmailAndPassword(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                         await controller.signInWithEmailAndPassword(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                      },
                      child: const Text('Login'),
                    );
            }),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Get.offAndToNamed('/registration');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

 
}
