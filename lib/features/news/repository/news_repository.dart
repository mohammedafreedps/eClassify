import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/components/storage_methods.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/news/model/news_model.dart';
import 'package:uuid/uuid.dart';

final newsRepostoryProvider = Provider<NewsRepostory>((ref) {
  return NewsRepostory(firestore: FirebaseFirestore.instance, ref: ref);
});

// final getLatestNewsProvider = FutureProvider((ref) async {
//   return ref.watch(newsRepostoryProvider).getLatestNews();
// });

class NewsRepostory {
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  NewsRepostory({
    required this.firestore,
    required this.ref,
  });

  FutureEither<NewsModel> uploadNewsToFirebase({
    required String title,
    required XFile file,
    required String description,
    required String userAddress,
    required String userPincode,
    required bool isSports,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final newsDocId = const Uuid().v1();
      final imageLinks = await StorageMethods().uploadImageToStorage(
        'news',
        file,
        true,
      );

      NewsModel newsModel = NewsModel(
        userModel: user,
        title: title,
        description: description,
        image: imageLinks,
        publishedAt: DateTime.now(),
        userAddress: userAddress,
        userPincode: userPincode,
        isSports: isSports,
      );

      await firestore.collection('news').doc(newsDocId).set(newsModel.toMap());

      return right(newsModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<NewsModel>> getAllNews() {
    return firestore.collection('news').snapshots().map(
          (event) => event.docs
              .map(
                (e) => NewsModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<NewsModel>> getNewsByPincode({
    required String userPincode,
  }) {
    return firestore
        .collection('news')
        .where("userPincode", isEqualTo: userPincode)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => NewsModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<NewsModel>> getSportsNews() {
    return firestore
        .collection('news')
        .where("isSports", isEqualTo: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => NewsModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
