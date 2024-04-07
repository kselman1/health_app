import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
 RegistrationView({super.key});


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.registerUser(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _phoneController.text,
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
