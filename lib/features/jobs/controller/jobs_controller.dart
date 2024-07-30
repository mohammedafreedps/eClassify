import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snack_bar.dart';
import '../model/job_model.dart';
import '../repository/jobs_repository.dart';


final jobsControllerProvider =
    StateNotifierProvider<JobsController, bool>((ref) {
  return JobsController(
    jobsRepository: ref.watch(jobsRepositoryProvider),
  );
});

final getAlljobsProvider = StreamProvider((ref) {
  return ref.watch(jobsControllerProvider.notifier).getAlljobs();
});

final getJobsByNameProvider = StreamProvider.family((ref, String title) {
  return ref.watch(jobsControllerProvider.notifier).getJobsByName(title);
});

final getAllJobCartItemsProvider = StreamProvider((ref) {
  return ref.watch(jobsControllerProvider.notifier).getAllJobCartItems();
});

class JobsController extends StateNotifier<bool> {
  final JobsRepository jobsRepository;
  JobsController({
    required this.jobsRepository,
  }) : super(false);

  Stream<List<JobModel>> getAlljobs() {
    return jobsRepository.getAlljobs();
  }

  Stream<List<JobModel>> getJobsByName(String title) {
    return jobsRepository.getJobsByName(title);
  }

  void saveJobCartToFirebase({
    required JobModel olxModel,
    required BuildContext context,
  }) async {
    final res = await jobsRepository.saveJobCartToFirebase(olxModel: olxModel);

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<JobModel>> getAllJobCartItems() {
    return jobsRepository.getAllJobCartItems();
  }
}
