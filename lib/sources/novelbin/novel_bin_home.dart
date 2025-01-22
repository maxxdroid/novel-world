import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/loading_states/loading_home.dart';
import 'package:novel_world/sources/novelbin/novelbin_service.dart';
import 'package:novel_world/pages/novelbin_deails.dart';

import '../../model/novel.dart';

class NovelBinHome extends StatefulWidget {
  const NovelBinHome({super.key});

  @override
  State<NovelBinHome> createState() => _NovelBinHomeState();
}

class _NovelBinHomeState extends State<NovelBinHome> {
  late Future<List<Novel>> novels;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  List<Novel> allNovels = [];
  bool isLoading = false;
  bool isInitialLoading = true; // To track the initial load state
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();
  final NovelBinService novelService = NovelBinService();


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

  Future<void> search () async {
    allNovels = await novelService.searchNovels(searchController.text);
    // print("done");
    // novels = Future.value(searchNovels);
    setState(() {
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
          mainAxisAlignment: isSearch ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
          children: [
            if(!isSearch)const Text("Novel World", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            isSearch ?
                //Search Bar
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.only(left: 20 ,bottom: 8),
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (_) {
                      search();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search"
                    ),
                  ),
                ) :
            IconButton(onPressed: () {
              setState(() {
                isSearch = true;
              });
            }, icon: const Icon(Icons.search)),


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
