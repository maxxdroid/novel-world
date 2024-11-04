import 'package:flutter/material.dart';

class LoadingNovel extends StatelessWidget {
  const LoadingNovel({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Loading")
          ],
        ),
      ),
    );
  }
}
