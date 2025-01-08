import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/widgets/novel_description.dart';

import '../controllers/chapter_controller.dart';
import '../pages/chapter_details.dart';

class NovelDetailsWidget extends StatefulWidget {
  final Novel novel;
  const NovelDetailsWidget({super.key, required this.novel});

  @override
  State<NovelDetailsWidget> createState() => _NovelDetailsWidgetState();
}

class _NovelDetailsWidgetState extends State<NovelDetailsWidget> with SingleTickerProviderStateMixin{
  late Novel novel;
  late TabController tabController;
  bool loading = false;
  bool ascending = false;
  final ChapterController chapterController = Get.put(ChapterController());

  @override
  void initState() {
    // TODO: implement initState
    novel = widget.novel;
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: Container(
              color: novel.color,
              height: height,
              width: width,
            )
        ),
        Positioned(
          top: 0,
          child: Image.network(
            novel.imgUrl ?? "",
            height: 200,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      novel.imgUrl ?? "",
                      height: 200,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              novel.title ?? "",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            child: Text(
                              "Author: ${novel.author}",
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            child: Text(
                              novel.status ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text("Source: NovelBin")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),



            // TabBar in the middle of the page
            TabBar(
              controller: tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              dividerColor: Colors.black,
              tabs: const [
                Tab(text: 'Description'),
                Tab(text: 'Chapters'),
              ],
            ),

            // Content of each tab
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  NovelDescription(novel: novel, inLibrary: true, onTap: () {}),
                  //Second Tab

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${novel.chapters?.length} Chapters",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                if (loading)
                                  const SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    chapterController.downloadNovel(novel);
                                  },
                                  child: const Icon(Icons.download),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ascending = !ascending;
                                    });
                                  },
                                  child: const Icon(Icons.sort),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          reverse: ascending,
                          itemCount: novel.chapters?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ChapterDetails(chapter: novel.chapters![index], novel: novel,));
                                },
                                title: Text(
                                  novel.chapters?[index].title ?? "",
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: const Icon(Icons.download),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}
