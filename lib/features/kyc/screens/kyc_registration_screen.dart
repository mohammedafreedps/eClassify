import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/loader.dart';
import '../../../core/theme/pallete.dart';
import '../../auth/models/user_modelaaa.dart';
import '../../jobs/screens/recuiter/recuiter_information_screen.dart';
import '../controller/kyc_controller.dart';
import '../model/kyc_model.dart';



class KYCRegistrationScreen extends ConsumerStatefulWidget {
  final UserModelS user;
  const KYCRegistrationScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KYCRegistrationScreenState();
}

class _KYCRegistrationScreenState extends ConsumerState<KYCRegistrationScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController adhaarController;
  late TextEditingController panController;
  late TextEditingController mobileController;
  late TextEditingController ifscCodeController;
  late TextEditingController areaPincodeController;
  late TextEditingController companyController;
  late TextEditingController accountNumberController;
  late TextEditingController ageController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    fatherNameController =
        TextEditingController(text: widget.user.kycModel?.fatherName ?? "");
    motherNameController =
        TextEditingController(text: widget.user.kycModel?.motherName ?? "");
    adhaarController =
        TextEditingController(text: widget.user.kycModel?.aadhaarNumber ?? "");
    panController =
        TextEditingController(text: widget.user.kycModel?.panNumber ?? "");
    mobileController =
        TextEditingController(text: widget.user.kycModel?.mobileNuber ?? "");
    ifscCodeController =
        TextEditingController(text: widget.user.kycModel?.ifscCode ?? "");
    areaPincodeController =
        TextEditingController(text: widget.user.kycModel?.areaPincode ?? "");
    companyController =
        TextEditingController(text: widget.user.kycModel?.company ?? "");
    accountNumberController =
        TextEditingController(text: widget.user.kycModel?.accountNumber ?? "");
    ageController =
        TextEditingController(text: widget.user.kycModel?.age.toString() ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.read(kYCControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("KYC"),
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Personal Information",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        title: "Name",
                        controller: nameController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Father Name",
                        controller: fatherNameController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Mother Name",
                        controller: motherNameController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Mobile Number",
                        controller: mobileController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Area Pincode",
                        controller: areaPincodeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Age",
                        keyboardType: TextInputType.number,
                        controller: ageController,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Other Information",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Company",
                        controller: companyController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Aadhaar Number",
                        keyboardType: TextInputType.number,
                        controller: adhaarController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Pan Number",
                        controller: panController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Bank Account Number",
                        keyboardType: TextInputType.number,
                        controller: accountNumberController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "IFSC Number",
                        keyboardType: TextInputType.number,
                        controller: ifscCodeController,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(kYCControllerProvider.notifier)
                                .uploadKYCDetails(
                                  kycModel: KYCModel(
                                    name: nameController.text.trim(),
                                    fatherName:
                                        fatherNameController.text.trim(),
                                    motherName:
                                        motherNameController.text.trim(),
                                    aadhaarNumber: adhaarController.text.trim(),
                                    panNumber: panController.text.trim(),
                                    mobileNuber: mobileController.text.trim(),
                                    email: emailController.text.trim(),
                                    ifscCode: ifscCodeController.text.trim(),
                                    areaPincode:
                                        areaPincodeController.text.trim(),
                                    age: int.parse(ageController.text.trim()),
                                    company: companyController.text.trim(),
                                    accountNumber:
                                        accountNumberController.text.trim(),
                                  ),
                                  context: context,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Pallete.greenColor,
                          foregroundColor: Pallete.whiteColor,
                        ),
                        child: const Text("COMPLETE"),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
