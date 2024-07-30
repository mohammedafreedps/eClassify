import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';


import '../../../core/error/server_exception.dart';
import '../../../core/error/type_defs.dart';

import '../../auth/controller/auth_controller.dart';
import '../../auth/models/user_modelaaa.dart';
import '../model/company_model.dart';
import '../model/job_model.dart';
import '../model/recruiter_profile_model.dart';

final recruiterRepositoryProvider = Provider<RecruiterRepository>((ref) {
  return RecruiterRepository(
    firestore: FirebaseFirestore.instance,
    userModel: ref.watch(userProvider)!,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class RecruiterRepository {
  final FirebaseFirestore firestore;
  final UserModelS userModel;
  final FirebaseAuth auth;
  final Ref ref;

  RecruiterRepository({
    required this.firestore,
    required this.userModel,
    required this.auth,
    required this.ref,
  });

  FutureEither<CompanyModel> uploadRecuiterCompanyDetails({
    required String companyName,
    required String industry,
    required String location,
    required String companyWebsiteURL,
    required int companySize,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      CompanyModel companyModel = CompanyModel(
        companyName: companyName,
        industry: industry,
        companySize: companySize,
        location: location,
        companyWebsiteURL: companyWebsiteURL,
        recruiterUid: user.uid,
      );

      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({"companyModel": companyModel.toMap()});

      await firestore.collection("users").doc(user.uid).update({
        'jobDetailsUpdated': "recruiter",
      });

      return right(companyModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<JobModel> uploadJobsDetails({
    required String jobTitle,
    required String jobDescription,
    required String jobLocation,
    required bool isRemote,
    required String recruiterUid,
    required int experience,
    required String education,
    required int salary,
    required String perTime,
  }) async {
    try {
      final user = ref.watch(userProvider)!;
      final docId = const Uuid().v1();

      JobModel jobModel = JobModel(
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        jobLocation: jobLocation,
        isRemote: isRemote,
        uid: user.uid,
        experience: experience,
        education: education,
        userModel: user,
        salary: salary,
        dateCreated: DateTime.now(),
        id: docId,
        perTime: perTime,
      );

      await firestore.collection("jobs").doc(docId).set(jobModel.toMap());

      return right(jobModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<JobModel>> getRecruiterjobs() {
    return firestore.collection("jobs").snapshots().map((event) => event.docs
        .map(
          (e) => JobModel.fromMap(
            e.data(),
          ),
        )
        .toList());
  }

  // FirebaseFirestore.instance.collection("recruiters").doc(user?.uid ?? "").collection("jobs").get()

  Future<CompanyModel?> getRecruiterCompanydetails() async {
    var res = await firestore.collection("recruiters").doc(userModel.uid).get();

    CompanyModel? companyModel;
    if (res.data() != null) {
      companyModel = CompanyModel.fromMap(res.data()!);
    } else {
      throw ServerException("No Doc found");
    }
    return companyModel;
  }

  Future<RecruiterProfileModel> getRecruiterProfileModel() async {
    return await firestore
        .collection("users")
        .doc(userModel.uid)
        .collection("jobProfile")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => RecruiterProfileModel.fromMap(value.data()!));
  }
}
