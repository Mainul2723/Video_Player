import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoapp/controller/homecontroller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Videos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            if (controller.isLoading.value && controller.videos.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.videos.length +
                      (controller.hasMoreVideos.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.videos.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final video = controller.videos[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => controller.onVideoSelected(video),
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
                            // Text(video['id'].toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
