import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:videoapp/screens/videoplayer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> videos = [];
  int currentPage = 1;
  bool hasMoreVideos = true;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchVideos();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchVideos();
      }
    });
  }

  Future<void> fetchVideos() async {
    if (isLoading || !hasMoreVideos) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'https://test-ximit.mahfil.net/api/trending-video/1?page=$currentPage'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> videoData = responseData['results'];

      if (videoData.isNotEmpty) {
        setState(() {
          videos.addAll(List<Map<String, dynamic>>.from(videoData));
          currentPage++;
        });
      } else {
        hasMoreVideos = false;
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Videos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (videos.isEmpty)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: videos.length + (hasMoreVideos ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == videos.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final video = videos[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayers(
                                video: video,
                              ),
                            ));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            video['thumbnail'],
                            width: 350,
                            errorBuilder: (context, error, stackTrace) {
                              print('Image loading error: $error');
                              return const Icon(Icons.error);
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(video['id'].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
