import 'package:flutter/material.dart';

import '../../../core/theme/pallete.dart';


class AuthIconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onpressed;
  final String text;
  const AuthIconButton({
    super.key,
    required this.imagePath,
    required this.onpressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        backgroundColor: Pallete.whiteColor,
        elevation: 0,
        side: BorderSide(color: Pallete.borderColor),
      ),
      icon: Image.asset(
        imagePath,
        height: 22,
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Pallete.blackColor,
        ),
      ),
    );
  }
}
