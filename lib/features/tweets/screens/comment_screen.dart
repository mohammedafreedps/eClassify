import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/tweets/controller/tweet_controller.dart';
import 'package:eClassify/features/tweets/model/tweet_model.dart';
import 'package:eClassify/features/tweets/widgets/comment_card.dart';

class CommentScreen extends ConsumerStatefulWidget {
  // final CommentModel commentModel;
  final TweetModel tweetModel;
  const CommentScreen({
    super.key,
    required this.tweetModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: ref.watch(getCommentProvider(widget.tweetModel.postId)).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final comment = data[index];
                  return CommentCard(
                    commentModel: comment,
                    tweetModel: widget.tweetModel,
                  );
                },
              );
            },
            error: (error, st) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () => const Loader(),
          ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 12, right: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment as ${user.name}',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (commentController.text.trim().isNotEmpty) {
                  ref.read(tweetControllerProvider.notifier).postComment(
                        postId: widget.tweetModel.postId,
                        text: commentController.text.trim(),
                      );

                  commentController.text = "";
                }
              },
              color: Pallete.whiteColor,
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.blueColor,
              ),
              icon: const Icon(Icons.arrow_upward),
            ),
          ],
        ),
      ),
    );
  }
}
