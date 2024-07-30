import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/components/storage_methods.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/tweets/model/comment_model.dart';
import 'package:eClassify/features/tweets/model/tweet_model.dart';
import 'package:uuid/uuid.dart';

final tweetRepositoryProvider = Provider<TweetRepository>((ref) {
  return TweetRepository(firestore: FirebaseFirestore.instance, ref: ref);
});

class TweetRepository {
  final FirebaseFirestore firestore;
  final ProviderRef ref;
  TweetRepository({
    required this.firestore,
    required this.ref,
  });

  FutureEither<TweetModel> shareTweets({
    required String text,
    required XFile file,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final postDocId = const Uuid().v1();
      final imageLinks = await StorageMethods().uploadImageToStorage(
        'tweets',
        file,
        true,
      );

      TweetModel postModel = TweetModel(
        text: text,
        hashtags: [],
        imageLinks: imageLinks,
        uid: user.uid,
        createdAt: DateTime.now(),
        likes: [],
        commentIds: [],
        postId: postDocId,
        sharedCount: 0,
        username: user.name,
        profilePic: user.profilePic,
      );

      await firestore
          .collection('tweets')
          .doc(postDocId)
          .set(postModel.toMap());

      return right(postModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<TweetModel>> getAllTweets() {
    return firestore.collection('tweets').snapshots().map(
          (event) => event.docs
              .map(
                (e) => TweetModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> likeTheTweets({
    required String postId,
    required List likes,
    required String uid,
  }) async {
    try {
      if (likes.contains(uid)) {
        await firestore.collection('tweets').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore.collection('tweets').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }

  // Future<void> commentTheTweet({
  //   required String postId,
  //   required List commentIds,
  //   required String message,
  // }) async {
  //   try {
  //     await firestore.collection('tweets').doc(postId).update({
  //       'commentIds': FieldValue.arrayUnion([message])
  //     });
  //   } catch (e) {}
  // }

  FutureEither<CommentModel> postComment({
    required String postId,
    required String text,
  }) async {
    try {
      final commentDocid = const Uuid().v1();
      final user = ref.watch(userProvider)!;

      CommentModel replymodel = CommentModel(
        profilePic: user.profilePic,
        userName: user.name,
        useruid: user.uid,
        text: text,
        commentId: commentDocid,
        datePublished: DateTime.now(),
        likes: [],
      );

      await firestore
          .collection('tweets')
          .doc(postId)
          .collection('comments')
          .doc(commentDocid)
          .set(replymodel.toMap());

      return right(replymodel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CommentModel>> getComments({
    required String postId,
  }) {
    return firestore
        .collection('tweets')
        .doc(postId)
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => CommentModel.fromMap(e.data())).toList(),
        );
  }

  Future<void> likeTheComments({
    required String tweetId,
    required String commentDocid,
    required List likes,
    required String uid,
  }) async {
    try {
      if (likes.contains(uid)) {
        await firestore
            .collection('tweets')
            .doc(tweetId)
            .collection('comments')
            .doc(commentDocid)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore
            .collection('tweets')
            .doc(tweetId)
            .collection('comments')
            .doc(commentDocid)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
