// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:eClassify/core/theme/pallete.dart';
// import 'package:eClassify/features/auth/controller/auth_controller.dart';
// import 'package:eClassify/features/jobs/screens/job_seeker/screens/job_seeker_inforation_screen.dart';
// import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
// import 'package:eClassify/features/onboarding/widgets/onboarding_button.dart';

// class JobseekerOrRecruiterScreen extends ConsumerWidget {
//   const JobseekerOrRecruiterScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider)!;

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Add your details to get started",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//               const Spacer(),
//               JobRecruiterWidget(
//                 imagePath: "assets/job/jobseeker.jpg",
//                 title: "I am a Job Seeker",
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     CupertinoPageRoute(
//                       builder: (context) => const JobSeekerInformationScreen(),
//                     ),
//                   );
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.4,
//                     child: const Divider(),
//                   ),
//                   Text(
//                     "Or",
//                     style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Pallete.greyColor,
//                         ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.4,
//                     child: const Divider(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               JobRecruiterWidget(
//                 imagePath: "assets/job/recruiter.jpg",
//                 title: "I am a Recruiter",
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     CupertinoPageRoute(
//                       builder: (context) =>
//                           RecuiterInformationScreen(userModel: user),
//                     ),
//                   );
//                 },
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class JobRecruiterWidget extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback onPressed;
//   const JobRecruiterWidget({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.3,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(imagePath, height: 120),
//           const SizedBox(height: 20),
//           OnboardingButtonWidget(
//             onPressed: onPressed,
//             text: title,
//             backgroungColor: Pallete.blueColor.withOpacity(0.7),
//             textColor: Pallete.whiteColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
