import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/news/model/live_stream_model.dart';

final liveStreamrepositryProvider = Provider<LiveStreamrepositry>((ref) {
  return LiveStreamrepositry(firestore: FirebaseFirestore.instance);
});

class LiveStreamrepositry {
  final FirebaseFirestore _firestore;

  LiveStreamrepositry({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  FutureEither<String> startLiveStream(
      BuildContext context, WidgetRef ref) async {
    final user = ref.watch(userProvider)!;
    String channelId = '';
    try {
      if (!((await _firestore
              .collection('livestream')
              .doc('${user.uid}${user.name}')
              .get())
          .exists)) {
        channelId = '${user.uid}${user.name}';

        LiveStreamModel liveStream = LiveStreamModel(
          title: user.name,
          image: user.profilePic,
          uid: user.uid,
          username: user.name,
          viewers: 0,
          channelId: channelId,
          startedAt: DateTime.now(),
        );

        _firestore
            .collection('livestream')
            .doc(channelId)
            .set(liveStream.toMap());
      } else {
        showSnackBar(context, 'Two Livestreams cannot start at the same time.');
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.code));
    }
    return right(channelId);
  }

  Future<void> leaveLiveStream(String channelId) async {
    try {
      _firestore.collection('livestream').doc(channelId).delete();
    } on FirebaseException catch (e) {
      return print(e.message);
    }
  }
}
