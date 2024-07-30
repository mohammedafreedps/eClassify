import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/delegates/olx_search_delegates.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/OLX/controller/olx_controller.dart';
import 'package:eClassify/features/OLX/screens/olx_cart_screen.dart';
import 'package:eClassify/features/OLX/screens/olx_details_screen.dart';
import 'package:eClassify/features/OLX/screens/olx_upload_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class OLXFeedScreen extends ConsumerWidget {
  const OLXFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: OLXSearchDelegate(
                  ref: ref,
                ),
              );
            },
            icon: const Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const OLXCartScreen(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.bag),
          ),
        ],
      ),
      body: ref.watch(getAllOlxItemsProvider).when(
            data: (data) {
              return GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  final olx = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => OLXDetailsScreen(
                                olxModel: olx,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    olx.imagePath.first,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Text(
                                    olx.title,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹${olx.prize}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          // color: kPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        timeago.format(olx.createAt),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Pallete.icongreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const OLXUploadScreen(),
            ),
          );
        },
        backgroundColor: Pallete.blueColor,
        foregroundColor: Pallete.whiteColor,
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}
