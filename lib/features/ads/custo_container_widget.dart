import 'package:flutter/material.dart';

import '../../core/theme/pallete.dart';



class CustomContainerWidget extends StatelessWidget {
  final String assetsName;
  final String title;
  final String price;
  final Color color;
  final double height;
  const CustomContainerWidget({
    Key? key,
    required this.assetsName,
    required this.title,
    required this.price,
    this.color = Pallete.greenColor,
    this.height = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          height: width * 0.25,
          width: width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Pallete.whiteColor,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                "₹$price",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Pallete.whiteColor,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                "/$assetsName",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Pallete.whiteColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
