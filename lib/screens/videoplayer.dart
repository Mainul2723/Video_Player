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
  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = FijkPlayer();
    _controller.setDataSource(widget.video['manifest'], autoPlay: true);

    _controller.addListener(() {
      setState(() {
        isVideoPlaying = _controller.value.state == FijkState.started;
      });
    });

    // Delay for 1 second and then play the video
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        _controller.start();
        setState(() {
          isVideoPlaying = true;
        });
      }
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
          Stack(
            alignment: Alignment.center,
            children: [
              // FijkView for video
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.state == FijkState.started) {
                      _controller.pause();
                    } else {
                      _controller.start();
                    }
                  });
                },
                child: FijkView(
                  player: _controller,
                  fit: FijkFit.contain,
                  width: 400,
                  height: 300,
                ),
              ),
              // Thumbnail
              if (!isVideoPlaying)
                Positioned.fill(
                  child: Image.network(
                    widget.video['thumbnail'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Image loading error: $error');
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              // Play button overlay
              if (!isVideoPlaying)
                Center(
                  child: IconButton(
                    icon: Icon(
                      _controller.value.state == FijkState.started
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.state == FijkState.started) {
                          _controller.pause();
                        } else {
                          _controller.start();
                        }
                      });
                    },
                  ),
                ),
            ],
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
          ),
        ],
      ),
    );
  }
}
