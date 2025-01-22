import 'package:flutter/material.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/widgets/novel_details.dart';

class NovelHiNovelDetails extends StatefulWidget {
  final Novel novel;
  const NovelHiNovelDetails({ required this.novel ,super.key});

  @override
  State<NovelHiNovelDetails> createState() => _NovelHiNovelDetailsState();
}

class _NovelHiNovelDetailsState extends State<NovelHiNovelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NovelDetailsWidget(novel: widget.novel),
    );
  }
}
