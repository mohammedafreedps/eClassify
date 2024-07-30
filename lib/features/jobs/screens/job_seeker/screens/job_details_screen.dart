import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/utils/show_dialogue.dart';
import '../../../../auth/controller/auth_controller.dart';
import '../../../model/job_model.dart';
import 'job_seeker_inforation_screen.dart';

class JobDetailsScreen extends ConsumerWidget {
  final JobModel jobModel;
  const JobDetailsScreen({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobModel.jobTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Image.asset(
                    "assets/job/education.png",
                    height: 23,
                  ),
                  Text(
                    "  ${jobModel.education}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "₹${jobModel.salary} Per ${jobModel.perTime}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Text(
                "EXP: ${jobModel.experience.toString()} Yrs",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Pallete.greyColor),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 22,
                  ),
                  Text(
                    jobModel.jobLocation,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              const Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      jobModel.userModel.profilePic,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobModel.userModel.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Job Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    jobModel.jobDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Details",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    jobModel.userModel.email,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    jobModel.userModel.address ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    jobModel.userModel.phoneNumber ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 35, top: 10, left: 10, right: 10),
        child: ElevatedButton(
          onPressed: () {
            if (user.jobDetailsUpdated != "job_seeker") {
              showAdaptiveDialogs(
                context,
                () {
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: SizedBox(
                        height: 270,
                        child: AlertDialog(
                          elevation: 0,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Update your job profile",
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                "You need to update your job profile to apply for this job",
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        JobSeekerInformationScreen(
                                      user: user,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Update Now",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              String url =
                  'https://wa.me/${int.parse(jobModel.userModel.phoneNumber!)}/?text=${Uri.parse('')}';
              launchUrl(Uri.parse(url));
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Pallete.greenColor,
            shadowColor: Colors.transparent,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Chat With Recruiter",
            style: TextStyle(
              fontSize: 14,
              color: Pallete.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
