import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/login/views/custom_button.dart';
import 'package:health_app/app/modules/login/views/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginb1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 45,
                          color: Colors.black),
                    )),
                const SizedBox(
                  height: 20,
                ),
                CustomLoginTextField(
                    onSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(controller.passwordFocusNode);
                    },
                    textController: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    labelText: 'Email'),
                const SizedBox(height: 40),
                CustomLoginTextField(
                    onSubmitted: (_) async {
                      await controller.signInWithEmailAndPassword(
                        controller.emailController.text.trim(),
                        controller.passwordController.text.trim(),
                      );
                    },
                    textController: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    labelText: 'Password'),
                const SizedBox(height: 20),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.black,)
                      : CustomButton(() async {
                          await controller.signInWithEmailAndPassword(
                            controller.emailController.text.trim(),
                            controller.passwordController.text.trim(),
                          );
                        }, Colors.white, Colors.black, text: 'Login');
                }),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomButton(() {
                    Get.toNamed('/registration');
                  }, Colors.black, Colors.white, text: 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
