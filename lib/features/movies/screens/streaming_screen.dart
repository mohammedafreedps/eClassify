import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/movies/repository/streaming_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({
//     super.key,
//     this.onBackPressed,
//   });

//   /// The action to perform when the back button is pressed.
//   final VoidCallback? onBackPressed;

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: StreamChannelHeader(
//         leading: StreamBackButton(
//           onPressed: () {
//             if (widget.onBackPressed != null) {
//               widget.onBackPressed!();
//             } else {
//               Navigator.of(context).pop();
//             }
//           },
//           showUnreadCount: false,
//         ),
//         subtitle: SizedBox(),
//         actions: [],
//       ),
//       body: Column(
//         children: const <Widget>[
//           Expanded(
//             child: StreamMessageListView(),
//           ),
//           StreamMessageInput(),
//         ],
//       ),
//     );
//   }
// }

// class CallScreen extends StatefulWidget {
//   const CallScreen({
//     Key? key,
//     required this.call,
//     required this.channel,
//   }) : super(key: key);

//   final Call call;
//   final Channel channel;

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   var isChatPaneVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: StreamCallContainer(
//             call: widget.call,
//             callContentBuilder: (context, call, callState) {
//               return StreamCallContent(
//                 call: call,
//                 callState: callState,
//                 onBackPressed: () => _finishCall(context),
//                 callControlsBuilder: (context, call, callState) {
//                   return StreamCallControls(
//                     options: customCallControlOptions(
//                       call: call,
//                       onLeaveCallTap: () => _finishCall(context),
//                       onChatTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return StreamChannel(
//                                 channel: widget.channel,
//                                 child: const ChatScreen(),
//                               );
//                             },
//                             fullscreenDialog: true,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         isChatPaneVisible
//             ? Expanded(
//                 flex: 1,
//                 child: StreamChannel(
//                   channel: widget.channel,
//                   child: ChatScreen(onBackPressed: () => toggleChatPane()),
//                 ),
//               )
//             : Container()
//       ],
//     );
//   }

//   void toggleChatPane() {
//     isChatPaneVisible = !isChatPaneVisible;
//     setState(() {});
//   }

//   Future<void> _finishCall(BuildContext context) async {
//     // await widget.call.disconnect();
//     await widget.channel.stopWatching();

//     Navigator.of(context).pop();
//   }
// }

// List<Widget> customCallControlOptions({
//   required Call call,
//   required VoidCallback onLeaveCallTap,
//   required VoidCallback onChatTap,
// }) {
//   final localParticipant = call.state.value.localParticipant;
//   assert(localParticipant != null, 'The local participant is null.');

//   final cid = Uuid().v1();

//   return [
//     ToggleChat(cid: cid, onChatTap: onChatTap),
//     ToggleMicrophoneOption(call: call, localParticipant: localParticipant!),
//     ToggleCameraOption(call: call, localParticipant: localParticipant),
//     FlipCameraOption(call: call, localParticipant: localParticipant),
//     LeaveCallOption(call: call, onLeaveCallTap: onLeaveCallTap),
//   ];
// }

// class ToggleChat extends StatelessWidget {
//   const ToggleChat({
//     Key? key,
//     required this.cid,
//     required this.onChatTap,
//   }) : super(key: key);

//   final VoidCallback onChatTap;

//   /// Channel cid used to retrieve unread count.
//   final String? cid;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CallControlOption(
//           icon: const Icon(Icons.chat),
//           iconColor: Colors.black,
//           backgroundColor: Colors.white,
//           onPressed: onChatTap,
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Text("data"),
//         ),
//       ],
//     );
//   }
// }

class MoviesScreen extends ConsumerStatefulWidget {
  const MoviesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  List<Map<String, dynamic>> videos = [];
  var isloading = false;
  final String title = "moviesdubbedinhindi";

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = true;
    });
    StreamingRepository()
        .fetchYouTubeVideos('AIzaSyD_j96ebqWDKf-wsPI1yG3IgOuST2RzIt8', title)
        .then((value) {
      setState(() {
        videos = value;
      });
    });
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: StreamingRepository().fetchYouTubeVideos(
                'AIzaSyD_j96ebqWDKf-wsPI1yG3IgOuST2RzIt8', title),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(videos[index]['title']),
                        leading: Image.network(
                          videos[index]['thumbnailUrl'],
                        ),
                        subtitle: Text(videos[index]['channelTitle']),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                videoId: videos[index]['id'],
                                videoTitle: videos[index]['title'],
                                channelTitle: videos[index]['channelTitle'],
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            }));
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;
  final String videoTitle;
  final String channelTitle;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.videoTitle,
    required this.channelTitle,
  });

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
              bottomActions: const [],
              bufferIndicator: const CircularProgressIndicator(),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.green,
              ),
            ),
            const SizedBox(height: 3),
            ListTile(
              title: Text(videoTitle),
              subtitle: Text(
                channelTitle,
                style: TextStyle(color: Pallete.greyColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LiveStreamScreen extends StatelessWidget {
//   const LiveStreamScreen({
//     super.key,
//     required this.livestreamCall,
//   });

//   final Call livestreamCall;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: StreamBuilder(
//         stream: livestreamCall.state.valueStream,
//         initialData: livestreamCall.state.value,
//         builder: (context, snapshot) {
//           final callState = snapshot.data!;
//           final participant = callState.callParticipants.first;
//           return Scaffold(
//             body: Stack(
//               children: [
//                 if (snapshot.hasData)
//                   StreamVideoRenderer(
//                     call: livestreamCall,
//                     videoTrackType: SfuTrackType.video,
//                     participant: participant,
//                   ),
//                 if (!snapshot.hasData)
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 if (snapshot.hasData && callState.status.isDisconnected)
//                   const Center(
//                     child: Text('Stream not live'),
//                   ),
//                 Positioned(
//                   top: 12.0,
//                   left: 12.0,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     color: Colors.red,
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Viewers: ${callState.callParticipants.length}',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 12.0,
//                   right: 12.0,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     color: Colors.black,
//                     child: GestureDetector(
//                       onTap: () {
//                         livestreamCall.end();
//                         Navigator.pop(context);
//                       },
//                       child: const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             'End Call',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
