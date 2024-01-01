import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';
import 'package:videoapp/screens/videoplayer.dart';

class HomeController extends GetxController {
  final videos = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final hasMoreVideos = true.obs;
  final currentPage = 1.obs;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchVideos();
      }
    });
  }

  Future<void> fetchVideos() async {
    if (isLoading.value || !hasMoreVideos.value) return;

    isLoading.value = true;

    final response = await http.get(
      Uri.parse(
          'https://test-ximit.mahfil.net/api/trending-video/1?page=${currentPage.value}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> videoData = responseData['results'];

      if (videoData.isNotEmpty) {
        videos.addAll(List<Map<String, dynamic>>.from(videoData));
        currentPage.value++;
      } else {
        hasMoreVideos.value = false;
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }

    isLoading.value = false;
  }

  void onVideoSelected(Map<String, dynamic> video) {
    Get.to(() => VideoPlayers(video: video));
  }
}
