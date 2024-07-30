import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';

class OLXDetailsScreen extends ConsumerWidget {
  final OLXModel olxModel;
  const OLXDetailsScreen({
    super.key,
    required this.olxModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9,
                ),
                items: olxModel.imagePath.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            i,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 15, left: 8, right: 8, bottom: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Text(
              //             olxModel.title,
              //             style:
              //                 Theme.of(context).textTheme.labelLarge!.copyWith(
              //                       fontWeight: FontWeight.bold,
              //                       // color: Pallete.greenColor,
              //                     ),
              //             softWrap: true,
              //             textAlign: TextAlign.start,
              //           ),
              //           const Text(' - '),
              //           Text(
              //             DateFormat.yMMMd().format(olxModel.createAt),
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .labelMedium!
              //                 .copyWith(
              //                     fontWeight: FontWeight.w500,
              //                     color: Pallete.greyColor),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   color: Pallete.icongreyColor.withOpacity(0.1),
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      olxModel.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "₹${olxModel.prize}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Pallete.icongreyColor.withOpacity(0.1),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Product Details",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      olxModel.details,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "Product Description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      olxModel.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Pallete.greenColor,
                shadowColor: Colors.transparent,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Chat Now",
                style: TextStyle(
                  fontSize: 14,
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
