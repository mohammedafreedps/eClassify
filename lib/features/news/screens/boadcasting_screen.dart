// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:eClassify/core/error/loader.dart';
// import 'package:eClassify/features/auth/controller/auth_controller.dart';
// import 'package:eClassify/features/news/controller/live_stream_controller.dart';

// class BroadcastScreen extends ConsumerStatefulWidget {
//   const BroadcastScreen({
//     super.key,
//   });

//   @override
//   ConsumerState<BroadcastScreen> createState() => _BroadcastScreenState();
// }

// class _BroadcastScreenState extends ConsumerState<BroadcastScreen> {
//   AgoraClient? client;
//   // late final RtcEngine _engine;
//   String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

//   @override
//   void initState() {
//     super.initState();
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: "43038e97603a48b2ba9c3ffcde14e5eb",
//         channelName: "test",
//         tokenUrl: baseUrl,
//       ),
//     );
//     initAgora();
//   }

//   void initAgora() async {
//     await client!.initialize();
//   }

//   _leaveChannel() async {
//     client!.engine.leaveChannel();
//   }

//   delectFirestore(String channelId) {
//     ref.watch(liveControllerProvider.notifier).leaveLiveStream(channelId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider)!;

//     return PopScope(
//       onPopInvoked: (didPop) async {
//         await _leaveChannel();
//         await delectFirestore("${user.uid}${user.name}");
//       },
//       child: Scaffold(
//         body: client == null
//             ? const Loader()
//             : SafeArea(
//                 child: Stack(
//                   children: [
//                     AgoraVideoViewer(client: client!),
//                     AgoraVideoButtons(
//                       client: client!,
//                       disconnectButtonChild: IconButton(
//                         onPressed: () async {
//                           // await client!.engine.leaveChannel();
//                           // ref.read(callControllerProvider).endCall(
//                           //       widget.call.callerId,
//                           //       widget.call.receiverId,
//                           //       context,
//                           //     );
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(Icons.call_end),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BroadcastScreen extends ConsumerStatefulWidget {
  const BroadcastScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BroadcastScreenState();
}

class _BroadcastScreenState extends ConsumerState<BroadcastScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
