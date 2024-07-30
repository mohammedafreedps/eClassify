import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:uuid/uuid.dart';

import '../../../core/error/type_defs.dart';
import '../../auth/controller/auth_controller.dart';
import '../model/job_model.dart';

final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  return JobsRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class JobsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final Ref ref;

  JobsRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  Stream<List<JobModel>> getAlljobs() {
    return firestore.collection('jobs').snapshots().map(
          (event) => event.docs
              .map(
                (e) => JobModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  // Future<JobModel?> getCartJobsById(String docId) {
  //   final user = ref.watch(userProvider)!;
  //   return firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .collection('jobcart')
  //       .doc(docId)
  //       .get()
  //       .then((value) => JobModel.fromMap(value.data()!));
  // }

  Stream<List<JobModel>> getJobsByName(String title) {
    return firestore
        .collection('jobs')
        .where(
          "jobTitle",
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
                (e) => JobModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  FutureEither<void> saveJobCartToFirebase({
    required JobModel olxModel,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final docId = const Uuid().v1();

      final res = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('jobcart')
          .doc(docId)
          .set(olxModel.toMap());

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<JobModel>> getAllJobCartItems() {
    final user = ref.watch(userProvider)!;

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('jobcart')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => JobModel.fromMap(e.data()),
              )
              .toList(),
        );
  }
}
