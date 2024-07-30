// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:eClassify/core/theme/pallete.dart';
// import 'package:eClassify/core/utils/pick_image.dart';
// import 'package:eClassify/features/Streaming/providers/streaming_provider.dart';
// import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
// import 'package:eClassify/features/tabbar/tabbar_screen.dart';

// class UploadStreamingScreen extends ConsumerStatefulWidget {
//   const UploadStreamingScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _UploadStreamingScreenState();
// }

// class _UploadStreamingScreenState extends ConsumerState<UploadStreamingScreen> {
//   XFile? image;
//   XFile? video;
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descController = TextEditingController();
//   bool uploading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: uploading
//           ? SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   const Text("Uploading..."),
//                   const Text("Do Not Close The App"),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(
//                           builder: (context) => TabbarScreen(
//                             isCompleted: uploading,
//                           ),
//                         ),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text("Upload in background"),
//                   ),
//                 ],
//               ),
//             )
//           : SingleChildScrollView(
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       image != null
//                           ? Container(
//                               height: 200,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.file(
//                                   File(image!.path),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () async {
//                                 XFile file = await pickImage();
//                                 setState(() {
//                                   image = file;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Pallete.borderColor.withOpacity(0.5),
//                                 ),
//                                 height: 200,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.image_search_outlined,
//                                       color: Pallete.icongreyColor,
//                                     ),
//                                     Text(
//                                       "Click here to select a tumbnail",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodySmall!
//                                           .copyWith(
//                                               color: Pallete.icongreyColor),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                       const SizedBox(height: 15),
//                       video != null
//                           ? Container(
//                               height: 100,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Center(child: Text(video!.name)),
//                             )
//                           : GestureDetector(
//                               onTap: () async {
//                                 // video = File('path_to_video_file.mp4');
//                                 XFile file = await pickVideo();
//                                 setState(() {
//                                   video = file;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Pallete.borderColor.withOpacity(0.5),
//                                 ),
//                                 height: 100,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.image_search_outlined,
//                                       color: Pallete.icongreyColor,
//                                     ),
//                                     Text(
//                                       "Click here to select a video",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodySmall!
//                                           .copyWith(
//                                               color: Pallete.icongreyColor),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                       Column(
//                         children: [
//                           const SizedBox(height: 15),
//                           InfoTextField(
//                             controller: titleController,
//                             title: "Add Title",
//                             maxLines: null,
//                           ),
//                           const SizedBox(height: 15),
//                           InfoTextField(
//                             controller: descController,
//                             title: "Add Description",
//                             maxLines: null,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 15),
//                       ElevatedButton(
//                         onPressed: () {
//                           uploading = true;
//                           ref
//                               .read(streamingControllerProvider.notifier)
//                               .uploadVideoesToFirebase(
//                                 title: titleController.text.trim(),
//                                 desc: descController.text.trim(),
//                                 image: image!,
//                                 video: video!,
//                                 context: context,
//                               );
//                           uploading = false;
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(double.infinity, 45),
//                           elevation: 0,
//                           backgroundColor: Pallete.blueColor,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                         ),
//                         child: const Text(
//                           "UPLOAD",
//                           style: TextStyle(color: Pallete.whiteColor),
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
