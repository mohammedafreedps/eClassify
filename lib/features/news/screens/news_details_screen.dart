import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/calculate_reading_time.dart';
import 'package:eClassify/features/news/model/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel newsModel;
  const NewsDetailsScreen({
    super.key,
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.network(
                    newsModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 2,
                  child: IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.whiteColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Pallete.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.userModel.name,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Pallete.greenColor,
                            ),
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                      const Text(' - '),
                      Text(
                        DateFormat.yMMMd().format(newsModel.publishedAt),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Pallete.greyColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.timelapse, color: Pallete.greyColor),
                      const SizedBox(width: 5),
                      Text(
                        "${calculateReadingTime(newsModel.description).toString()} min",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Pallete.greyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Pallete.icongreyColor.withOpacity(0.1),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.title,
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
                    newsModel.description,
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
    );
  }
}
