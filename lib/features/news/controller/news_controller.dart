import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/news/model/news_model.dart';
import 'package:eClassify/features/news/repository/news_repository.dart';

final newsControllerProvider =
    StateNotifierProvider<NewsController, bool>((ref) {
  return NewsController(
    ref.watch(newsRepostoryProvider),
  );
});

final getAllNewsProvider = StreamProvider((ref) {
  return ref.watch(newsControllerProvider.notifier).getAllNews();
});

final getNewsByPincodeProvider =
    StreamProvider.family((ref, String userPincode) {
  return ref
      .watch(newsControllerProvider.notifier)
      .getNewsByPincode(userPincode: userPincode);
});

final getSportsNewsProvider = StreamProvider((ref) {
  return ref.watch(newsControllerProvider.notifier).getSportsNews();
});

class NewsController extends StateNotifier<bool> {
  final NewsRepostory newsRepostory;
  NewsController(
    this.newsRepostory,
  ) : super(false);

  void uploadNewsToFirebase({
    required String title,
    required XFile file,
    required String description,
    required BuildContext context,
    required String userAddress,
    required String userPincode,
    required bool isSports,
  }) async {
    state = true;
    final res = await newsRepostory.uploadNewsToFirebase(
      title: title,
      file: file,
      description: description,
      userAddress: userAddress,
      userPincode: userPincode,
      isSports: isSports,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<NewsModel>> getAllNews() {
    return newsRepostory.getAllNews();
  }

  Stream<List<NewsModel>> getNewsByPincode({
    required String userPincode,
  }) {
    return newsRepostory.getNewsByPincode(userPincode: userPincode);
  }

  Stream<List<NewsModel>> getSportsNews() {
    return newsRepostory.getSportsNews();
  }
}
