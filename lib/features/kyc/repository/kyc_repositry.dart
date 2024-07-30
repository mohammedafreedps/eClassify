import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/error/type_defs.dart';
import '../../auth/controller/auth_controller.dart';
import '../model/kyc_model.dart';



final kYCReositoryProvider = Provider<KYCReository>((ref) {
  return KYCReository(
    firestore: FirebaseFirestore.instance,
    ref: ref,
  );
});

class KYCReository {
  final FirebaseFirestore firestore;
  final Ref ref;

  KYCReository({
    required this.firestore,
    required this.ref,
  });

  FutureEither<KYCModel> uploadKYCDetails({
    required KYCModel kycModel,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      firestore.collection("users").doc(user.uid).update({
        'kycModel': kycModel.toMap(),
      });

      return right(kycModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Future<KYCModel> getKYCDetails() async {
  //   final user = ref.watch(userProvider)!;

  //   return await firestore.collection("users").doc(user.uid).get().then(
  //         (value) => KYCModel.fromMap(value.data() as Map<String, dynamic>),
  //       );
  // }
}
