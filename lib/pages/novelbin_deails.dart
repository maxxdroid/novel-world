import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/sources/novelbin/services/novelbin_service.dart';
import 'package:novel_world/pages/chapter_details.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/library_controller.dart';

class NovelBinDetails extends StatefulWidget {
  final Novel novel;
  const NovelBinDetails({super.key, required this.novel});

  @override
  State<NovelBinDetails> createState() => _NovelBinDetailsState();
}

class _NovelBinDetailsState extends State<NovelBinDetails> with SingleTickerProviderStateMixin{
  late WebViewController controller;
  bool loading = true;
  bool isDescriptionExpanded = false; // For toggling description
  bool ascending = false; // For toggling sorting
  bool inLibrary = false;
  Novel? updatedNovel;
  late Future<Novel?> novel;
  late Color color;
  final LibraryController libraryController = Get.put(LibraryController());
  late TabController tabController;


  Future<void> _fetchAndProcessHtml() async {
    try {

      String doc = await controller.runJavaScriptReturningResult('document.documentElement.innerHTML') as String;
      var jsonString = json.decode(doc);
      var dom = parse(jsonString);

      Novel? novelWithChapters = await NovelBinService().getChaptersFromDocument(widget.novel, dom);

      setState(() {
        updatedNovel = novelWithChapters;
        loading = false;
      });
    } catch (e) {
      print("Error fetching and processing HTML content: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    novel = NovelBinService().getChapters(widget.novel);
    tabController = TabController(length: 2, vsync: this);
    inLibrary = libraryController.novelInLibrary(widget.novel);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onPageFinished: (_) async {
          await Future.delayed(const Duration(seconds: 1));
          _fetchAndProcessHtml();
        }),
      )
      ..loadRequest(Uri.parse("${widget.novel.link!}#tab-chapters-title"));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 1,
            width: 1,
            child: Visibility(
                visible: false,
                child: WebViewWidget(controller: controller)),
          ),
          SizedBox(
            height: height,
            child: FutureBuilder<Novel?>(
              initialData: widget.novel,
              future: novel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final novel = snapshot.data;

                  Future<PaletteGenerator> updatePalette() async {
                    final PaletteGenerator generator =
                    await PaletteGenerator.fromImageProvider(
                        Image.network(novel?.imgUrl ?? "").image);
                    return generator;
                  }

                  return Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: FutureBuilder(
                          future: updatePalette(),
                          builder: (context, AsyncSnapshot<PaletteGenerator> snapshot) {
                            if (snapshot.hasError) {
                              return const SizedBox();
                            } else if (snapshot.hasData) {
                              Color c = snapshot.data!.lightMutedColor?.color != null ? snapshot.data!.lightMutedColor!.color: Colors.grey;
                              color = c;
                              novel?.color = c;
                              return Container(
                                color: c,
                                height: height,
                                width: width,
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Image.network(
                          novel!.imgUrl ?? "",
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
                          Flexible(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                description(width, height, novel),
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
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                ascending = !ascending;
                                              });
                                            },
                                            child: const Icon(Icons.sort),
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
                } else {
                  return const Center(child: Text("No Data Found"));
                }
              },
            ),
          ),
        ],
      ),
    ); 
  }

  Widget description (double width, double height, Novel newNovel) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: width,// Fixed height when collapsed
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text(
                    newNovel.description ?? "",),
                  const Text(
                    "Tags",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, // Horizontal space between tags
                    runSpacing: 4.0, // Vertical space between rows of tags
                    children: (newNovel.genres?.split(", ") ?? []).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(), ),
                  const SizedBox(height: 100,),
                ],
              ),
            ),
            Container(alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 20),
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: (){},
                      child: SizedBox(
                        width: width * .3,
                        height: 50,
                        child: const Center(
                          child: Text("Start Reading", overflow: TextOverflow.ellipsis,),
                        ),
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){

                        if(!inLibrary) {
                          libraryController.addToLibrary(newNovel);
                          setState(() {
                            inLibrary = true;
                          });
                        } else {
                          libraryController.removeFromLibrary(newNovel);
                          setState(() {
                            inLibrary = false;
                          });
                        }

                      },
                      child: SizedBox(
                        width: width * .3,
                        height: 50,
                        child: Center(
                          child: inLibrary ? const Text("Remove", overflow: TextOverflow.ellipsis)
                          : const Text("Add to Library", overflow: TextOverflow.ellipsis),
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}

