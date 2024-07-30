import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/components/storage_methods.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(firestore: FirebaseFirestore.instance);
});

class ProfileRepository {
  final FirebaseFirestore firestore;

  ProfileRepository({required this.firestore});

  Future<Either<String, void>> updateUser({
    required String docId,
    required String? name,
    required XFile? profilePic,
    required WidgetRef ref,
    required String userPincode,
    required String address,
  }) async {
    try {
      final profilePicstorage = await StorageMethods().uploadImageToStorage(
        "profilePic",
        profilePic!,
        false,
      );
      final res = await firestore.collection('users').doc(docId).update({
        'name': name,
        "userPincode": userPincode,
        "address": address,
        'profilePic': profilePicstorage,
      });

      return right(res);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> updateUserNameOnly({
    required String docId,
    required String? name,
    required WidgetRef ref,
    required String userPincode,
    required String address,
  }) async {
    try {
      final res = await firestore.collection('users').doc(docId).update({
        'name': name,
        "userPincode": userPincode,
        "address": address,
      });

      return right(res);
    } catch (e) {
      return left(e.toString());
    }
  }
}
