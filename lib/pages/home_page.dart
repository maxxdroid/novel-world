import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/loading_states/loading_home.dart';
import 'package:novel_world/novelbin/novelbin_service.dart';
import 'package:novel_world/pages/novelbin_deails.dart';

import '../model/novel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Novel>> novels;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  List<Novel> allNovels = [];
  bool isLoading = false;
  bool isInitialLoading = true; // To track the initial load state

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Novel World", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
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
                        return const Center(child: CircularProgressIndicator()); // Pagination loading indicator
                      }

                      final novel = allNovels[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => NovelBinDetails(novel: novel));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(novel.imgUrl ?? "", height: 160, fit: BoxFit.cover),
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Text(novel.title ?? "", overflow: TextOverflow.fade),
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
