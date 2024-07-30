
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';


import '../../core/error/type_defs.dart';
import '../auth/controller/auth_controller.dart';


final adsRepositoryProvider = Provider<AdsRepository>((ref) {
  return AdsRepository(firestore: FirebaseFirestore.instance, ref: ref);
});

class AdsRepository {
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  AdsRepository({required this.firestore, required this.ref});

  FutureEither<void> saveShoppingCartToFirebase({
    required String title,
    required String description,
    required int selectedPrice,
    required XFile file,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      final res = await firestore.collection('ads').doc(user.uid).set({
        'title': title,
        'description': description,
        'selectedPrice': selectedPrice,
        'image': file,
      });

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
