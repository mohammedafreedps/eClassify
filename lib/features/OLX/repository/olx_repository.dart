import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/components/storage_methods.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:uuid/uuid.dart';

final olxRepositoryProvider = Provider<OLXRepository>((ref) {
  return OLXRepository(
    firestore: FirebaseFirestore.instance,
    ref: ref,
  );
});

class OLXRepository {
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  OLXRepository({
    required this.firestore,
    required this.ref,
  });

  FutureEither<OLXModel> uploadOLXToFirebase({
    required String title,
    required String description,
    required int prize,
    required String details,
    required List<XFile?> imagePath,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final newsDocId = const Uuid().v1();
      final imageLinks = await StorageMethods().uploadImages(imagePath);

      OLXModel olxModel = OLXModel(
        title: title,
        description: description,
        prize: prize,
        details: details,
        imagePath: imageLinks,
        createAt: DateTime.now(),
        userUid: user.uid,
        userModel: user,
      );

      await firestore.collection('olx').doc(newsDocId).set(olxModel.toMap());

      return right(olxModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<OLXModel>> getAllOlxItems() {
    return firestore.collection('olx').snapshots().map(
          (event) => event.docs
              .map(
                (e) => OLXModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  FutureEither<void> saveOLXCartToFirebase({
    required OLXModel olxModel,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final docId = const Uuid().v1();

      final res = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('olxCart')
          .doc(docId)
          .set(olxModel.toMap());

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<OLXModel>> getAllOlxCartItems() {
    final user = ref.watch(userProvider)!;

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('olxCart')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => OLXModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  Stream<List<OLXModel>> getOLXByName(String title) {
    return firestore
        .collection('olx')
        .where(
          "title",
          isLessThan: title.isEmpty
              ? null
              : title.substring(0, title.length - 1) +
                  String.fromCharCode(
                    title.codeUnitAt(title.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => OLXModel.fromMap(e.data()),
              )
              .toList(),
        );
  }
}
