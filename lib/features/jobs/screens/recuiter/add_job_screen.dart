import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/loader.dart';
import '../../../../core/theme/pallete.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../controller/recruiter_profile_controller.dart';


class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key});

  @override
  ConsumerState<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final formKey = GlobalKey<FormState>();
  bool isRemote = false;
  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobLocationController = TextEditingController();
  final experienceController = TextEditingController();
  final educationController = TextEditingController();
  final salaryController = TextEditingController();
  String dropdownvalue = 'Month';

  var items = [
    'Hour',
    'Day',
    'Week',
    'Month',
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isLoading = ref.watch(recruiterProfileControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const LoadingScreen()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Post a Full Time Job",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        InfoTextField(
                          title: "Add Job Title",
                          controller: jobTitleController,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: InfoTextField(
                                title: "Add Salary",
                                controller: salaryController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 15),
                            DropdownButton(
                              borderRadius: BorderRadius.circular(2),
                              underline: null,
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        InfoTextField(
                          title: "Add Job Description",
                          controller: jobDescriptionController,
                          maxLines: null,
                        ),
                        const SizedBox(height: 5),
                        InfoTextField(
                          title: "Add Job Location",
                          controller: jobLocationController,
                        ),
                        const SizedBox(height: 5),
                        InfoTextField(
                          title: "Add Experience In Years",
                          controller: experienceController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 5),
                        InfoTextField(
                          title: "Add min Education",
                          controller: educationController,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Note: The job title, job type, job description, job location cannot be modified after the job as posted.",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Pallete.greyColor),
                        ),
                        Divider(color: Pallete.borderColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.home_outlined),
                                Text(
                                  "This is a remote job",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Switch.adaptive(
                              value: isRemote,
                              activeColor: Pallete.blueColor,
                              onChanged: (val) {
                                setState(() {
                                  isRemote = val;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // if (user.phoneNumber!.isNotEmpty) {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(recruiterProfileControllerProvider
                                      .notifier)
                                  .uploadJobsDetails(
                                    jobTitle: jobTitleController.text,
                                    jobDescription:
                                        jobDescriptionController.text,
                                    jobLocation: jobLocationController.text,
                                    isRemote: isRemote,
                                    recruiterUid: user.uid,
                                    salary: int.parse(
                                      salaryController.text.trim(),
                                    ),
                                    context: context,
                                    experience: int.parse(
                                      experienceController.text.trim(),
                                    ),
                                    education: educationController.text.trim(),
                                    perTime: dropdownvalue,
                                  );
                            }
                            // } else {
                            //   showAdaptiveDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return Scaffold(
                            //         body: Center(
                            //           child: SizedBox(
                            //             height: 400,
                            //             child: AlertDialog(
                            //               elevation: 0,
                            //               content: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     "Update your Phone Number",
                            //                     maxLines: 2,
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .titleLarge,
                            //                   ),
                            //                   Text(
                            //                     "You need to update your phone number to upload jobs",
                            //                     maxLines: 2,
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .bodyMedium!
                            //                         .copyWith(),
                            //                   ),
                            //                 ],
                            //               ),
                            //               actions: [
                            //                 TextButton(
                            //                   onPressed: () {
                            //                     Navigator.of(context).pop();
                            //                   },
                            //                   child: const Text(
                            //                     "Cancel",
                            //                     style: TextStyle(
                            //                         color: Colors.red),
                            //                   ),
                            //                 ),
                            //                 TextButton(
                            //                   onPressed: () {
                            //                     Navigator.of(context).push(
                            //                       CupertinoPageRoute(
                            //                         builder: (context) =>
                            //                             EditProfilescreen(
                            //                                 userModel: user),
                            //                       ),
                            //                     );
                            //                   },
                            //                   child: const Text(
                            //                     "Update Now",
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40),
                            backgroundColor: Pallete.blueColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide.none,
                          ),
                          child: const Text(
                            "CONTINUE",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
