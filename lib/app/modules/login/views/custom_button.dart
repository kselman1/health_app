import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/login/controllers/login_controller.dart';

class CustomButton extends GetView<LoginController> {
  
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color bckgColor;

  const CustomButton(this.onPressed, this.textColor, this.bckgColor, {
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
          border: Border.all(color: Colors.black, width: 2),
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
