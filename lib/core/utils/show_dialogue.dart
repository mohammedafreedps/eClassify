import 'package:flutter/material.dart';

Future<dynamic> showAdaptiveDialogs(
  BuildContext context,
  VoidCallback onPressed,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            height: 300,
            child: AlertDialog(
              elevation: 0,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update your address",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "You need to update your address to upload news",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: const Text(
                    "Update Now",
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
