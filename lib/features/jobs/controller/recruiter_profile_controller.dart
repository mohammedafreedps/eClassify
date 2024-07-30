import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snack_bar.dart';
import '../model/company_model.dart';
import '../model/job_model.dart';
import '../repository/recruiter_repository.dart';


final recruiterProfileControllerProvider =
    StateNotifierProvider<RecruiterController, bool>((ref) {
  return RecruiterController(
      recruiterRepository: ref.watch(recruiterRepositoryProvider));
});

final getRecruiterCompanydetailsProvider = FutureProvider((ref) {
  final controller = ref.watch(recruiterProfileControllerProvider.notifier);
  return controller.getRecruiterCompanydetails();
});

final getRecruiterjobsProvider = StreamProvider((ref) {
  final controller = ref.watch(recruiterProfileControllerProvider.notifier);
  return controller.getRecruiterjobs();
});

class RecruiterController extends StateNotifier<bool> {
  final RecruiterRepository recruiterRepository;
  RecruiterController({
    required this.recruiterRepository,
  }) : super(false);

  void uploadRecuiterCompanyDetails({
    required String companyName,
    required String industry,
    required String location,
    required String companyWebsiteURL,
    required int companySize,
    required BuildContext context,
  }) async {
    state = true;
    final res = await recruiterRepository.uploadRecuiterCompanyDetails(
      companyName: companyName,
      industry: industry,
      location: location,
      companyWebsiteURL: companyWebsiteURL,
      companySize: companySize,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  void uploadJobsDetails({
    required String jobTitle,
    required String jobDescription,
    required String jobLocation,
    required bool isRemote,
    required String recruiterUid,
    required BuildContext context,
    required int experience,
    required String education,
    required int salary,
    required String perTime,
  }) async {
    state = true;
    final res = await recruiterRepository.uploadJobsDetails(
      jobTitle: jobTitle,
      jobDescription: jobDescription,
      jobLocation: jobLocation,
      isRemote: isRemote,
      recruiterUid: recruiterUid,
      experience: experience,
      education: education,
      salary: salary,
      perTime: perTime,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<JobModel>> getRecruiterjobs() {
    return recruiterRepository.getRecruiterjobs();
  }

  Future<CompanyModel?> getRecruiterCompanydetails() async {
    CompanyModel? compamodel =
        await recruiterRepository.getRecruiterCompanydetails();
    return compamodel;
  }
}
