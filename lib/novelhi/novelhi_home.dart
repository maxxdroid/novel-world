import 'package:flutter/material.dart';

class NovelHiHome extends StatefulWidget {
  const NovelHiHome({super.key});

  @override
  State<NovelHiHome> createState() => _NovelHiHomeState();
}

class _NovelHiHomeState extends State<NovelHiHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novel Hi"),
      ),
      body: const Center()
    );
  }
}
