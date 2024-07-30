import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/snack_bar.dart';
import '../repository/job_seeker_repository.dart';


final jobSeekerControllerProvider =
    StateNotifierProvider<JobSeekerController, bool>((ref) {
  return JobSeekerController(
    jobSeekerRepository: ref.watch(jobSeekerRepositoryProvider),
  );
});

class JobSeekerController extends StateNotifier<bool> {
  final JobSeekerRepository jobSeekerRepository;
  JobSeekerController({
    required this.jobSeekerRepository,
  }) : super(false);

  void uploadUserPersonalDetailsToFirestore({
    required String jobTitle,
    required int experience,
    required String bio,
    required XFile resume,
    required BuildContext context,
  }) async {
    state = true;
    final res = await jobSeekerRepository.uploadUserPersonalDetailsToFirestore(
      jobTitle: jobTitle,
      experience: experience,
      bio: bio,
      resume: resume,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }
}
