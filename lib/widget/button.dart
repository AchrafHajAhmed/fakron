import 'package:flutter/material.dart';
import 'package:fakron/color.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: AppColors.buttoncolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: const Size(200, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.textcolor,
          fontSize: 16,
        ),
      ),
    );
  }
}

