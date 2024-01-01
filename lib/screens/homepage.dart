import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoapp/controller/homecontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                            ListTile(
                              // leading: Image.asset(
                              //   'assets/channel.png',
                              //   width: 40,
                              //   height: 40,
                              // ),
                              leading: Container(
                                width: 50,
                                height: 45,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/channel.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              title: Text(
                                video['title'].toString(),
                                style: GoogleFonts.mina(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "${video['viewers']} Views",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ".",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(
                                        DateTime.parse(video['created_at'])),
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert)),
                            ),
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
