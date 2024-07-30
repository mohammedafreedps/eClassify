// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:eClassify/core/error/loader.dart';
// import 'package:eClassify/core/theme/pallete.dart';
// import '../../auth/models/user_model.dart';
// import 'package:eClassify/features/jobs/controller/recruiter_profile_controller.dart';

// class RecuiterInformationScreen extends ConsumerStatefulWidget {
//   final UserModel userModel;
//   const RecuiterInformationScreen({
//     super.key,
//     required this.userModel,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _RecuiterInformationScreenState();
// }

// class _RecuiterInformationScreenState
//     extends ConsumerState<RecuiterInformationScreen> {
//   late TextEditingController nameController;
//   final jobPositionController = TextEditingController();
//   late TextEditingController emailController;
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(
//         text: widget.userModel.name); // widget.userModel.name);
//     emailController = TextEditingController(
//         text: widget.userModel.email); // widget.userModel.email);
//   }

//   void uploadRecuiterData(String recruiterUid) {
//     if (formKey.currentState!.validate()) {
//       ref
//           .read(recruiterProfileControllerProvider.notifier)
//           .(
//             fullName: nameController.text,
//             jobPosition: jobPositionController.text,
//             email: emailController.text,
//             recruiterUid: recruiterUid,
//             context: context,
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = ref.watch(recruiterProfileControllerProvider);

//     return Scaffold(
//       body: isLoading
//           ? const Loader()
//           : SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Recruiter Profile",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineSmall!
//                             .copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         "Introduce yourself to the candidates",
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                               fontWeight: FontWeight.w500,
//                               color: Pallete.greyColor,
//                             ),
//                       ),
//                       const SizedBox(height: 20),
//                       InfoTextField(
//                         title: "Full Name",
//                         controller: nameController,
//                       ),
//                       const SizedBox(height: 15),
//                       InfoTextField(
//                         title: "My Job Position",
//                         controller: jobPositionController,
//                       ),
//                       const SizedBox(height: 15),
//                       InfoTextField(
//                         title: "My Email",
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           uploadRecuiterData(widget.userModel.uid);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(double.infinity, 40),
//                           backgroundColor: Pallete.blueColor,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           side: BorderSide.none,
//                         ),
//                         child: const Text(
//                           "NEXT",
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                             color: Pallete.whiteColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/theme/pallete.dart';


class InfoTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLines;
  InfoTextField({
    super.key,
    required this.title,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
  });

  final border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Pallete.borderColor,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "$title is missing!";
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(title),
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        enabledBorder: border,
        border: border,
        focusedBorder: border,
        labelStyle: const TextStyle(
          color: Pallete.icongreyColor,
        ),
      ),
      maxLines: maxLines,
    );
  }
}
