// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:eClassify/core/theme/pallete.dart';
// import 'package:video_player/video_player.dart';
// import 'package:eClassify/features/Streaming/model/streaming_model.dart';

// class VideoPlayingScreen extends StatefulWidget {
//   final StreamingModel streamingModel;
//   const VideoPlayingScreen({
//     super.key,
//     required this.streamingModel,
//   });

//   @override
//   _VideoPlayingScreenState createState() => _VideoPlayingScreenState();
// }

// class _VideoPlayingScreenState extends State<VideoPlayingScreen> {
//   late VideoPlayerController controller;
//   // final bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.streamingModel.videoPath),
//     )..initialize().then((value) {
//         controller.play();
//         controller.setVolume(1);
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Player Demo'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               AspectRatio(
//                 aspectRatio: controller.value.aspectRatio,
//                 child: VideoPlayer(controller),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Positioned(
//                 right: MediaQuery.of(context).size.width / 2,
//                 top: MediaQuery.of(context).size.width / 2,
//                 child: IconButton.filled(
//                   color: Pallete.whiteColor,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Pallete.blueColor,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       controller.value.isPlaying
//                           ? controller.pause()
//                           : controller.play();
//                     });
//                   },
//                   icon: Icon(
//                     controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         widget.streamingModel.userModel.profilePic,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.streamingModel.title,
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Text(
//                   widget.streamingModel.desc,
//                   maxLines: null,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 Text(
//                   DateFormat.yMMMd().format(widget.streamingModel.createdAt),
//                   maxLines: null,
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(color: Pallete.greyColor),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     setState(() {
//       //       _controller.value.isPlaying
//       //           ? _controller.pause()
//       //           : _controller.play();
//       //     });
//       //   },
//       //   child: Icon(
//       //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//       //   ),
//       // ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
// }
