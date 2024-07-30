import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/news/controller/news_controller.dart';
import 'package:eClassify/features/news/screens/add_news_screen.dart';
import 'package:eClassify/features/news/screens/news_details_screen.dart';

class SportsNewsScreen extends ConsumerWidget {
  const SportsNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sports News"),
        centerTitle: false,
        elevation: 0,
      ),
      body: ref.watch(getSportsNewsProvider).when(
            data: (data) {
              return data.isEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Looks like There are no sports news"),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const AddNewsScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.whiteColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Pallete.borderColor),
                              ),
                            ),
                            child: const Text(
                              "Add Yours",
                              style: TextStyle(color: Pallete.blackColor),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final news = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => NewsDetailsScreen(
                                        newsModel: news,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        news.image,
                                        height: 90,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 230,
                                            child: Text(
                                              news.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      // fontWeight: FontWeight.w600,
                                                      ),
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                              maxLines: 3,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              // Text(
                                              //   news.image,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodySmall!
                                              //       .copyWith(
                                              //           fontWeight: FontWeight.w500,
                                              //           color: Pallete.greyColor),
                                              // ),
                                              Text(
                                                DateFormat.yMMMd()
                                                    .format(news.publishedAt),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Pallete.greyColor),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    );
            },
            error: (error, st) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoadingScreen(),
          ),
    );
  }
}
