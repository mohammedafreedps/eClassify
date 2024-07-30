import 'package:flutter/material.dart';

class JobCustomButton extends StatelessWidget {
  const JobCustomButton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.backgroundolor,
    required this.textcolor,
  });

  final VoidCallback onpressed;
  final String text;
  final Color backgroundolor;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundolor,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.40, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textcolor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
