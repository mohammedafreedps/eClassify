import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/error/error_text.dart';
import '../../../../../core/error/loader.dart';
import '../../../../../core/theme/pallete.dart';
import '../../../../auth/controller/auth_controller.dart';
import '../../../controller/jobs_controller.dart';
import '../../../model/job_model.dart';
import '../../recuiter/add_job_screen.dart';
import 'job_details_screen.dart';
import 'job_seeker_inforation_screen.dart';

class JobFeedScreen extends ConsumerStatefulWidget {
  const JobFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobFeedScreenState();
}

class _JobFeedScreenState extends ConsumerState<JobFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs"),
        actions: [
          if (user.jobDetailsUpdated!.isEmpty)
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => JobSeekerInformationScreen(
                      user: user,
                    ),
                  ),
                );
              },
              child: const Text(
                "Update job preferences",
              ),
            ),
          // IconButton(
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: JobSearchDelegate(ref: ref),
          //     );
          //   },
          //   icon: const Icon(CupertinoIcons.search),
          // ),
          // if (user.jobDetailsUpdated == "job_seeker")
          //   IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         CupertinoPageRoute(
          //           builder: (context) => const SavedJobScreen(),
          //         ),
          //       );
          //     },
          //     icon: const Icon(CupertinoIcons.heart),
          //   ),
        ],
      ),
      body: ref.watch(getAlljobsProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final job = data[index];
                  return JobFeedDetailsWidget(job: job);
                },
              );
            },
            error: (error, st) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoadingScreen(),
          ),
      floatingActionButton: user.jobDetailsUpdated == "recruiter"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const AddJobScreen(),
                  ),
                );
              },
              backgroundColor: Pallete.blueColor,
              foregroundColor: Pallete.whiteColor,
              child: const Icon(
                Icons.add,
                size: 25,
              ),
            )
          : null,
    );
  }
}

class JobFeedDetailsWidget extends ConsumerWidget {
  const JobFeedDetailsWidget({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => JobDetailsScreen(
                jobModel: job,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Pallete.borderColor),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              job.userModel.profilePic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.jobTitle,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "₹${job.salary} Per ${job.perTime}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 22,
                                    ),
                                    Text(
                                      job.jobLocation,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        job.isRemote
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade200),
                                child: const Text(
                                  'Remote',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: Text(
                            job.experience <= 1
                                ? 'Entry level'
                                : job.experience < 5
                                    ? 'Mid-Senior level'
                                    : 'Senior level',
                          ),
                        )
                      ],
                    ),
                    Text(
                      "${timeago.format(job.dateCreated)} ",
                      style: const TextStyle(
                        color: Pallete.icongreyColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


  // Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: TextFormField(
  //             keyboardType: TextInputType.text,
  //             decoration: InputDecoration(
  //               hintText: 'b',
  //               alignLabelWithHint: true,
  //               floatingLabelAlignment: FloatingLabelAlignment.start,
  //               enabledBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(15),
  //                 ),
  //               ),
  //               border: const OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(15),
  //                 ),
  //               ),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(15),
  //                 ),
  //               ),
  //               filled: true,
  //               fillColor: Colors.grey.withOpacity(0.1),
  //               labelStyle: const TextStyle(
  //                 color: Pallete.icongreyColor,
  //               ),
  //             ),
  //           ),
  //         ),