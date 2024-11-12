import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/loading_states/loading_home.dart';
import 'package:novel_world/novelbin/novelbin_service.dart';
import 'package:novel_world/pages/novelbin_deails.dart';

import '../model/novel.dart';

class SourceHome extends StatefulWidget {
  const SourceHome({super.key});

  @override
  State<SourceHome> createState() => _SourceHomeState();
}

class _SourceHomeState extends State<SourceHome> {
  late Future<List<Novel>> novels;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  List<Novel> allNovels = [];
  bool isLoading = false;
  bool isInitialLoading = true; // To track the initial load state

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));

    fetchNovels(page, isInitial: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
        _onEndReached();
      }
    });
  }

  Future<void> fetchNovels(int page, {bool isInitial = false}) async {
    setState(() {
      isLoading = true;
    });

    try {
      var newNovels = await NovelBinService().getAllHotNovels(page);

      if (newNovels.isNotEmpty) {
        setState(() {
          allNovels.addAll(newNovels);
          novels = Future.value(allNovels);
        });
        print("Saving Locally");
        CachingService().saveNovelBinHomeNovels(allNovels);
      } else if (isInitial) {
        // Load from cache if no data from the API during the initial fetch
        await getCachedNovels();
      }
    } catch (e) {
      // Handle error and load cached novels if there was an issue
      if (isInitial) {
        await getCachedNovels();
      }
    } finally {
      setState(() {
        isLoading = false;
        isInitialLoading = false; // Stop initial loading indicator
      });
    }
  }

  Future<void> getCachedNovels() async {
    var cachedNovels = await CachingService().getNovelBinHomeNovels();
    setState(() {
      allNovels = cachedNovels;
      novels = Future.value(allNovels);
      print(novels.toString());
    });
  }

  void _onEndReached() {
    page++;
    fetchNovels(page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Novel World", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            child: isInitialLoading
                ? const LoadingHome()// Initial loading indicator
                : GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: allNovels.length + (isLoading ? 1 : 0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 0,
                      childAspectRatio: .5,
                    ),
                    itemBuilder: (context, index) {
                      if (index == allNovels.length) {
                        return Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Colors.grey.shade50,
                              child: const SizedBox(height: 160, width: 100,),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade50,
                              ),
                              height: 40,
                            )
                          ],
                        );
                      }

                      final novel = allNovels[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => NovelBinDetails(novel: novel));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Colors.grey.shade50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(novel.imgUrl ?? "", height: 160, fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Text(novel.title ?? "", overflow: TextOverflow.fade, textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
