import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/news/repository/live_stream_repository.dart';
import 'package:eClassify/features/news/screens/boadcasting_screen.dart';

final liveControllerProvider =
    StateNotifierProvider<LiveController, bool>((ref) {
  return LiveController(
    ref.watch(liveStreamrepositryProvider),
  );
});

class LiveController extends StateNotifier<bool> {
  final LiveStreamrepositry liveStreamrepositry;
  LiveController(
    this.liveStreamrepositry,
  ) : super(false);

  void startLiveStream({
    required WidgetRef ref,
    required BuildContext context,
    required String uid,
  }) async {
    state = true;
    final res = await liveStreamrepositry.startLiveStream(context, ref);
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const BroadcastScreen(),
        ),
      ),
    );
  }

  Future<void> leaveLiveStream(String channelId) async {
    await liveStreamrepositry.leaveLiveStream(channelId);
  }
}
