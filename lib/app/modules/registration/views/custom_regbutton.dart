import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/registration/controllers/registration_controller.dart';

class CustomRegButton extends GetView<RegistrationController> {
  
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color bckgColor;

  const CustomRegButton(this.onPressed, this.textColor, this.bckgColor, {
    super.key,
    
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.red, width: 2),
          color: bckgColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
