import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/tweets/controller/tweet_controller.dart';
import 'package:eClassify/features/tweets/screens/add_tweet_screen.dart';
import 'package:eClassify/features/tweets/screens/comment_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../app/routes.dart';

class TweetFeedScreen extends ConsumerWidget {
  const TweetFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) {
      // If user is null, redirect to the login page
      Future.microtask(() {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login,
              (route) => false,
        );
      });
      // Returning a placeholder widget while navigating to avoid build errors
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tweets"),
      ),
      body: ref.watch(getAllTweetsProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final tweetmodel = data[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(tweetmodel.profilePic),
                                ),
                                const SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tweetmodel.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      "@${tweetmodel.username}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          tweetmodel.imageLinks!,
                          // fit: BoxFit.fill,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .watch(tweetControllerProvider.notifier)
                                  .likeTheTweets(
                                    postId: tweetmodel.postId,
                                    likes: tweetmodel.likes,
                                    uid: user.uid,
                                  );
                            },
                            icon: tweetmodel.likes.contains(user.uid)
                                ? const Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                    size: 25,
                                  )
                                : const Icon(
                                    CupertinoIcons.heart,
                                    size: 25,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => CommentScreen(
                                    tweetModel: tweetmodel,
                                    // commentModel: tweetmodel,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.conversation_bubble,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 4),
                        child: Text(
                          "${tweetmodel.likes.length.toString()} Likes",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${tweetmodel.username} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: tweetmodel.text,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          maxLines: null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "${timeago.format(tweetmodel.createdAt, locale: 'en_short')} ago",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Pallete.greyColor,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                    ],
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
              builder: (context) => const AddPostScreen(),
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
