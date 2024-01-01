// ignore_for_file: library_private_types_in_public_api, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';

class VideoPlayers extends StatefulWidget {
  final Map<String, dynamic> video;

  const VideoPlayers({Key? key, required this.video}) : super(key: key);

  @override
  _VideoPlayersState createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late FijkPlayer _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = FijkPlayer();
    _controller.setDataSource(widget.video['manifest'], autoPlay: true);
    // print("URL: ");
    // print(widget.video['manifest'].toString());
    _controller.addListener(() {
      print(
          "Error during playback: ${_controller.value.exception} - ${_controller.value.exception}");
    });
  }

  @override
  void dispose() {
    _controller.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video ID: ${widget.video['id'].toString()}'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            FijkView(
              player: _controller,
              fit: FijkFit.contain,
              width: 400,
              height: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.video['title'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
