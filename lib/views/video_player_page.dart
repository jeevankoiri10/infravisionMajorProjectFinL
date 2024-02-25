// import 'package:flutter/material.dart';
// import 'package:appinio_video_player/appinio_video_player.dart';

// class VideoPlayerPage extends StatefulWidget {
//   const VideoPlayerPage({super.key});

//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late CustomVideoPlayerController _customVideoPlayerController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initializeVideoPlayer();
//   }

//   @override
//   void dispose() {
//     _customVideoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       width: 500,
//       child: Scaffold(
//         body: SafeArea(
//           child: CustomVideoPlayer(
//             customVideoPlayerController: _customVideoPlayerController,
//           ),
//         ),
//       ),
//     );
//   }

//   String assetVideoSingle = "assets/Solo.mp4";
//   String assetVideoDuo = "assets/Duo.mp4";

//   void initializeVideoPlayer() {
//     VideoPlayerController? videoPlayerController;
//     videoPlayerController = VideoPlayerController.asset(assetVideoSingle)
//       ..initialize().then((value) {
//         videoPlayerController!.play();
//         videoPlayerController.setLooping(true);
//         setState(() {});
//       });
//     _customVideoPlayerController = CustomVideoPlayerController(
//         context: context,
//         videoPlayerController: videoPlayerController,
//         customVideoPlayerSettings: CustomVideoPlayerSettings(
//           playOnlyOnce: false,
//           playbackSpeedButtonAvailable: false,
//           showSeekButtons: false,
//           showFullscreenButton: false,
//           showPlayButton: false,
//           controlBarAvailable: false,
//           settingsButtonAvailable: false,
//         ));
//   }
// }
