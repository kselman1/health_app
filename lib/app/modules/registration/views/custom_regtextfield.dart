import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/registration/controllers/registration_controller.dart';

class CustomRegistrationTextField extends GetView<RegistrationController> {
  final TextEditingController textController;
  final FocusNode focusNode;
  final String labelText;
  final Function(String)? onSubmitted;

  const CustomRegistrationTextField({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.labelText, 
    this.onSubmitted, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.red, width: 2),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: labelText=='Password'? true:false,
        controller: textController,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:const TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
