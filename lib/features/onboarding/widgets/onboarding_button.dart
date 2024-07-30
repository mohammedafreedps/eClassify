import 'package:flutter/material.dart';

class OnboardingButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroungColor;
  final Color textColor;
  const OnboardingButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroungColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroungColor,
        shadowColor: Colors.transparent,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.40, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
