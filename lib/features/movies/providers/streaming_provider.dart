// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:eClassify/core/utils/snack_bar.dart';
// import 'package:eClassify/features/Streaming/model/streaming_model.dart';
// import 'package:eClassify/features/Streaming/repository/streaming_repository.dart';

// final streamingControllerProvider =
//     StateNotifierProvider<StreamingController, bool>((ref) {
//   return StreamingController(
//     ref.watch(streamingRepositoryProvider),
//   );
// });

// final getAllStreaingItemsProvider = StreamProvider((ref) {
//   final controller = ref.watch(streamingControllerProvider.notifier);
//   return controller.getAllStreaingItems();
// });

// class StreamingController extends StateNotifier<bool> {
//   final StreamingRepository streamingRepository;

//   StreamingController(
//     this.streamingRepository,
//   ) : super(false);

//   void uploadVideoesToFirebase({
//     required String title,
//     required String desc,
//     required XFile image,
//     required XFile video,
//     required BuildContext context,
//   }) async {
//     state = true;
//     final res = await streamingRepository.uploadVideoesToFirebase(
//       title: title,
//       desc: desc,
//       image: image,
//       video: video,
//     );
//     state = false;

//     res.fold(
//       (l) => showSnackBar(context, l.text),
//       (r) => showSnackBar(context, "Uploaded Successfully"),
//     );
//   }

//   Stream<List<StreamingModel>> getAllStreaingItems() {
//     return streamingRepository.getAllStreaingItems();
//   }
// }
