import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/error/loader.dart';
import '../../../../../core/theme/pallete.dart';
import '../../../../../core/utils/pick_image.dart';
import '../../../../../core/utils/snack_bar.dart';
import '../../../../auth/models/user_modelaaa.dart';
import '../../../controller/job_seeker_controller.dart';
import '../../recuiter/recuiter_company_details_screen.dart';
import '../../recuiter/recuiter_information_screen.dart';





class JobSeekerInformationScreen extends ConsumerStatefulWidget {
  final UserModelS user;
  const JobSeekerInformationScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JobSeekerInformationScreenState();
}

class _JobSeekerInformationScreenState
    extends ConsumerState<JobSeekerInformationScreen> {
  late TextEditingController jobTitleController;
  late TextEditingController experienceController;
  late TextEditingController bioController;
  XFile? resume;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    jobTitleController =
        TextEditingController(text: widget.user.jobSeekerProfileModel.jobTitle);
    experienceController = TextEditingController(
        text: widget.user.jobSeekerProfileModel.experience.toString());
    bioController =
        TextEditingController(text: widget.user.jobSeekerProfileModel.bio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(jobSeekerControllerProvider);

    return Scaffold(
      body: isLoading
          ? const Loader()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Profile",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Introduce yourself to the Recruiter",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Completing the profile will help you connect with more recruiters",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Pallete.greyColor),
                      ),
                      const SizedBox(height: 20),
                      InfoTextField(
                        title: "Job Title",
                        controller: jobTitleController,
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Experience",
                        controller: experienceController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Add Bio",
                        controller: bioController,
                      ),
                      const SizedBox(height: 15),
                      resume != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Pallete.borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(resume!.name),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final XFile res = await pickPdf(context);

                                setState(
                                  () {
                                    resume = res;
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border:
                                      Border.all(color: Pallete.borderColor),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text("Upload Resume"),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              resume != null) {
                            ref
                                .read(jobSeekerControllerProvider.notifier)
                                .uploadUserPersonalDetailsToFirestore(
                                  jobTitle: jobTitleController.text.trim(),
                                  experience: int.parse(
                                    experienceController.text.trim(),
                                  ),
                                  bio: bioController.text.trim(),
                                  resume: resume!,
                                  context: context,
                                );
                          } else {
                            showSnackBar(context, "Please select resume");
                          }
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
                          "COMPLETE",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const RecuiterCompanyDetailsScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your a Recruiter? ",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                            Text(
                              "update as recruiter",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
