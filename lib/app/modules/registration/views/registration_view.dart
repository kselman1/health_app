import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:health_app/app/modules/registration/views/custom_regbutton.dart';
import 'package:health_app/app/modules/registration/views/custom_regtextfield.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Image.asset(
            'assets/images/regy.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          // Scrollable content
          SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Registration',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 45,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CustomRegistrationTextField(
                      onSubmitted: (_) {
                        FocusScope.of(context)
                          .requestFocus(controller.focusNodes[1]);
                      },
                      textController: controller.nameController,
                      focusNode: controller.focusNodes[0],
                      labelText: 'Name',
                    ),
                    const SizedBox(height: 20,),
                    CustomRegistrationTextField(
                      onSubmitted: (_) {
                        FocusScope.of(context)
                          .requestFocus(controller.focusNodes[2]);
                      },
                      textController: controller.emailController,
                      focusNode: controller.focusNodes[1],
                      labelText: 'Email',
                    ),
                    const SizedBox(height: 20,),
                    CustomRegistrationTextField(
                      onSubmitted: (_) {
                        FocusScope.of(context)
                          .requestFocus(controller.focusNodes[3]);
                      },
                      textController: controller.passwordController,
                      focusNode: controller.focusNodes[2],
                      labelText: 'Password',
                    ),
                    const SizedBox(height: 20,),
                    CustomRegistrationTextField(
                      onSubmitted: (_) async {
                        await controller.registerUser(
                          controller.nameController.text,
                          controller.emailController.text,
                          controller.passwordController.text,
                          controller.phoneController.text,
                        );
                      },
                      textController: controller.nameController,
                      focusNode: controller.focusNodes[3],
                      labelText: 'Phone',
                    ),
                    const SizedBox(height: 20,),
                    Obx(() {
                      return controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomRegButton(
                          () async {
                            await controller.registerUser(
                              controller.nameController.text,
                              controller.emailController.text,
                              controller.passwordController.text,
                              controller.phoneController.text,
                            );
                          },
                          Colors.white,
                          Colors.red,
                          text: 'Register',
                        );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

