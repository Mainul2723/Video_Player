import 'package:flutter/material.dart';
import 'package:videoapp/controller/homecontroller.dart';
import 'package:videoapp/screens/homepage.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Center(
      child: Scaffold(
        body: const HomePage(),
      ),
    );
  }
}
