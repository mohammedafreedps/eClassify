import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/tweets/controller/tweet_controller.dart';
import 'package:eClassify/features/tweets/model/comment_model.dart';
import 'package:eClassify/features/tweets/model/tweet_model.dart';

class CommentCard extends ConsumerWidget {
  final CommentModel commentModel;
  final TweetModel tweetModel;
  const CommentCard({
    super.key,
    required this.commentModel,
    required this.tweetModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(commentModel.profilePic),
              ),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${commentModel.userName}  ",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        timeago.format(commentModel.datePublished,
                            locale: 'en_short'),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "${commentModel.text} ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(tweetControllerProvider.notifier).likeTheComments(
                        tweetId: tweetModel.postId,
                        commentDocid: commentModel.commentId,
                        likes: commentModel.likes,
                        uid: user.uid,
                      );
                },
                child: commentModel.likes.contains(user.uid)
                    ? const Icon(
                        CupertinoIcons.heart_fill,
                        color: Pallete.redColor,
                      )
                    : Icon(
                        CupertinoIcons.heart,
                        color: Pallete.greyColor,
                      ),
              ),
              Text(
                commentModel.likes.length.toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
