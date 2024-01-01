// ignore_for_file: library_private_types_in_public_api, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:google_fonts/google_fonts.dart';

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
    DateTime createdAt = DateTime.parse(widget.video['created_at']);
    DateTime currentDate = DateTime.now();
    int daysDifference = currentDate.difference(createdAt).inDays;
    return Scaffold(
      appBar: AppBar(
        title: Text('Video ID: ${widget.video['id'].toString()}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 30,
          // ),
          FijkView(
            player: _controller,
            fit: FijkFit.contain,
            width: 400,
            height: 300,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.video['title'],
                  style: GoogleFonts.mina(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${widget.video['viewers']} Views",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "${daysDifference} days ago",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 233, 231, 231),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.favorite_border_outlined),
                      Text(
                        'Masha Allah',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 233, 231, 231),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined),
                      Text(
                        'Like(12k)',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 233, 231, 231),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.mobile_screen_share_outlined),
                        Text(
                          'Share',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 233, 231, 231),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.flag_outlined),
                      Text(
                        'Report',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
