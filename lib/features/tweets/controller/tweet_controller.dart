import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/tweets/model/comment_model.dart';
import 'package:eClassify/features/tweets/model/tweet_model.dart';

import 'package:eClassify/features/tweets/repository/tweet_repository.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
    ref.watch(tweetRepositoryProvider),
  );
});

final getAllTweetsProvider = StreamProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getAllTweets();
});

final getCommentProvider = StreamProvider.family((ref, String postId) {
  return ref
      .watch(tweetControllerProvider.notifier)
      .getComments(postId: postId);
});

class TweetController extends StateNotifier<bool> {
  final TweetRepository tweetRepository;
  TweetController(
    this.tweetRepository,
  ) : super(false);

  void shareTweets({
    required String text,
    required XFile file,
    required BuildContext context,
  }) async {
    state = true;
    final res = await tweetRepository.shareTweets(
      text: text,
      file: file,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<TweetModel>> getAllTweets() {
    return tweetRepository.getAllTweets();
  }

  void likeTheTweets({
    required String postId,
    required List likes,
    required String uid,
  }) async {
    tweetRepository.likeTheTweets(postId: postId, likes: likes, uid: uid);
  }

  void postComment({
    required String postId,
    required String text,
  }) async {
    tweetRepository.postComment(postId: postId, text: text);
  }

  Stream<List<CommentModel>> getComments({
    required String postId,
  }) {
    return tweetRepository.getComments(postId: postId);
  }

  void likeTheComments({
    required String tweetId,
    required String commentDocid,
    required List likes,
    required String uid,
  }) {
    tweetRepository.likeTheComments(
      tweetId: tweetId,
      commentDocid: commentDocid,
      likes: likes,
      uid: uid,
    );
  }
}
