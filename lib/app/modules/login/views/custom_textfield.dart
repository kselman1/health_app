import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/login/controllers/login_controller.dart';

class CustomLoginTextField extends GetView<LoginController> {
  final TextEditingController textController;
  final FocusNode focusNode;
  final String labelText;
  final Function(String)? onSubmitted;

  const CustomLoginTextField({
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
        border: Border.all(color: Colors.black, width: 2),
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
