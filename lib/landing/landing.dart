import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaySplash();
  }

  void displaySplash () {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage("assets/images/novel_world.png"),
              color: Colors.black,
              size: 100,
            ),
            Text("Novel World", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
