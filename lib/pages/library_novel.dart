import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_world/controllers/library_controller.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/widgets/novel_details.dart';

import '../sources/novelhi/views/novel_hi_offline_details.dart';

class LibraryNovel extends StatefulWidget {
  final int index;
  const LibraryNovel({super.key, required this.index});

  @override
  State<LibraryNovel> createState() => _LibraryNovelState();
}

class _LibraryNovelState extends State<LibraryNovel> {
  final LibraryController libraryController = Get.put(LibraryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        Novel novel = libraryController.novels[widget.index];
        if (novel.source == "Novel Bin") {
          return NovelDetailsWidget(novel: novel);
        } else {
          return NovelHiOffline(novel: novel);
        }
      }),
    );
  }
}
