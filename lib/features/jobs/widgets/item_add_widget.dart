import 'package:flutter/material.dart';

import '../../../core/theme/pallete.dart';


class ItemAddWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const ItemAddWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Pallete.blueColor,
        side: const BorderSide(color: Pallete.blueColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(
        Icons.add,
        size: 20,
      ),
      label: Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
