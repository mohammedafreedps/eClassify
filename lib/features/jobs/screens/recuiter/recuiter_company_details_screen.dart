import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/loader.dart';
import '../../../../core/theme/pallete.dart';
import '../../controller/recruiter_profile_controller.dart';


class RecuiterCompanyDetailsScreen extends ConsumerStatefulWidget {
  const RecuiterCompanyDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecuiterCompanyDetailsScreenState();
}

class _RecuiterCompanyDetailsScreenState
    extends ConsumerState<RecuiterCompanyDetailsScreen> {
  final companyNameController = TextEditingController();
  final industryController = TextEditingController();
  final locationController = TextEditingController();
  final companyWebsiteURLController = TextEditingController();
  final companySizeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void uploadRecuiterCompanyData() {
    if (formKey.currentState!.validate()) {
      ref
          .read(recruiterProfileControllerProvider.notifier)
          .uploadRecuiterCompanyDetails(
            companyName: companyNameController.text,
            industry: industryController.text,
            location: locationController.text,
            companyWebsiteURL: companyWebsiteURLController.text,
            companySize: int.parse(companySizeController.text),
            context: context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(recruiterProfileControllerProvider);

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
                        "Introduce yourself to the Candidates",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Pallete.greyColor,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Pallete.blueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.home_work,
                                color: Pallete.blueColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InfoTextField(
                              title: "Company Legal Name",
                              controller: companyNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Industry",
                        controller: industryController,
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Company Size",
                        controller: companySizeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Company Location",
                        controller: locationController,
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Company Website",
                        controller: companyWebsiteURLController,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          uploadRecuiterCompanyData();
                          Navigator.of(context).pop();
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
                          "SAVE AND CONTINUE",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class SelectInfoTextField extends StatelessWidget {
  final String text;
  const SelectInfoTextField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.5,
          color: Pallete.borderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
