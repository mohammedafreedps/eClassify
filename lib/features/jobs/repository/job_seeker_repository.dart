import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/storage_methods.dart';
import '../../../core/error/type_defs.dart';
import '../../auth/controller/auth_controller.dart';
import '../model/job_seeker_profile_model.dart';


final jobSeekerRepositoryProvider = Provider<JobSeekerRepository>((ref) {
  return JobSeekerRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class JobSeekerRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final Ref ref;

  JobSeekerRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  FutureEither<JobSeekerProfileModel> uploadUserPersonalDetailsToFirestore({
    required String jobTitle,
    required int experience,
    required String bio,
    required XFile resume,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      final resumes =
          await StorageMethods().uploadImageToStorage("resumes", resume, false);

      JobSeekerProfileModel jobSeekerProfileModel = JobSeekerProfileModel(
        name: user.name,
        email: user.email,
        jobTitle: jobTitle,
        experience: experience,
        bio: bio,
        resume: resumes,
      );

      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({'jobSeekerProfileModel': jobSeekerProfileModel.toMap()});

      await firestore.collection("users").doc(user.uid).update({
        'jobDetailsUpdated': "job_seeker",
      });

      return right(jobSeekerProfileModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
