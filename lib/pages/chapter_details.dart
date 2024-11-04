import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:novel_world/novelbin/novelbin_service.dart';

import '../model/chapter.dart';

class ChapterDetails extends StatefulWidget {
  final Chapter chapter;
  const ChapterDetails({super.key, required this.chapter});

  @override
  State<ChapterDetails> createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails> {
  late Future<Chapter> chapter;
  bool _isAppBarVisible = false;
  late String next;
  late String prev;

  @override
  void initState() {
    super.initState();
    loadChapter(); // Load the initial chapter
  }

  void loadChapter() {
    // Initialize chapter based on the current widget.chapter
    chapter = NovelBinService().getChapterContent(widget.chapter);
    chapter.then((chapterData) {
      setState(() {
        next = chapterData.next ?? "";
        prev = chapterData.previous ?? "";
      });
    });
  }

  void _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        setState(() => _isAppBarVisible = false);
      } else if (notification.direction == ScrollDirection.forward) {
        setState(() => _isAppBarVisible = true);
      } else if (metrics.atEdge && metrics.pixels == metrics.maxScrollExtent) {
        setState(() => _isAppBarVisible = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const SizedBox(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _onScroll(notification);
          return true;
        },
        child: FutureBuilder<Chapter>(
          future: chapter,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final chapter = snapshot.data;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 60),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: Text(
                        chapter?.title ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      child: Text(
                        chapter?.content ?? "",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isAppBarVisible ? 60.0 : 0.0,
        child: Wrap(
          children: [
            bottomCard(),
          ],
        ),
      ),
    );
  }

  Widget bottomCard() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {
          }, icon: const Icon(Icons.menu)),
          IconButton(
            onPressed: () {
              if (prev.isNotEmpty) {
                Chapter prevChapter = Chapter(link: prev);
                setState(() {
                  widget.chapter.link = prevChapter.link;
                  loadChapter(); // Reload previous chapter
                });
              }
            },
            icon: const Icon(Icons.navigate_before_outlined),
          ),
          IconButton(
            onPressed: () {
              if (next.isNotEmpty) {
                Chapter nextChapter = Chapter(link: next);
                setState(() {
                  widget.chapter.link = nextChapter.link;
                  loadChapter(); // Reload next chapter
                });
              }
            },
            icon: const Icon(Icons.navigate_next_outlined),
          ),
        ],
      ),
    );
  }
}
