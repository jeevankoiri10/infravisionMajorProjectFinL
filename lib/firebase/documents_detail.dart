import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infravision/notifications/notification_controller.dart';
import 'package:video_player/video_player.dart';

class DocumentDetailsPage extends StatefulWidget {
  final String documentId;

  DocumentDetailsPage({required this.documentId});

  @override
  _DocumentDetailsPageState createState() => _DocumentDetailsPageState();
}

class _DocumentDetailsPageState extends State<DocumentDetailsPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isLoading = true;
  bool _isShownImages = false;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();

    // Delay execution by 5 seconds and then execute print statement
    Future.delayed(Duration(seconds: 4), () {
      print('Delayed print statement after 4 seconds');
      NotificationController.initializeLocalNotifications();
      NotificationController.createNewNotificationForLocationDetection();
      _isShownImages = true;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    try {
      final videoURL = await downloadVideoURL();
      _videoPlayerController = VideoPlayerController.network(
        videoURL,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _initializeVideoPlayerFuture = _videoPlayerController.initialize();
      _videoPlayerController.addListener(() {
        setState(() {});
      });
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> downloadVideoURL() async {
    try {
      final downloadURL = await FirebaseFirestore.instance
          .collection('database')
          .doc(widget.documentId)
          .get()
          .then((doc) => doc['listOfVideos'][0]);
      return downloadURL;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentId),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('database')
            .doc(widget.documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${data['name']}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Video:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                _isLoading
                    ? CircularProgressIndicator()
                    : PlayVideo(
                        videoURL: _videoPlayerController.dataSource ?? '',
                        videoName: data['name'] ?? '',
                      ),
                SizedBox(height: 10),
                Text(
                  'List of Images:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _isShownImages
                    ? Column(
                        children: (data['listOfImages'] as List<dynamic>)
                            .map<Widget>((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      )
                    : Container(),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PlayVideo extends StatefulWidget {
  PlayVideo({Key? key, required this.videoURL, required this.videoName})
      : super(key: key);

  final String videoURL;
  final String videoName;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoURL,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

class DelayedColumn extends StatefulWidget {
  final Duration delay;
  final List<Widget> children;

  const DelayedColumn({Key? key, required this.delay, required this.children})
      : super(key: key);

  @override
  _DelayedColumnState createState() => _DelayedColumnState();
}

class _DelayedColumnState extends State<DelayedColumn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.delay,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(widget.delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Return an empty container while waiting
        } else {
          return AnimatedOpacity(
            opacity: 1,
            duration: widget.delay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.children,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
