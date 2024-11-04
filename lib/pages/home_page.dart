import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool isLoading = false; // To track loading state

  @override
  void initState() {
    super.initState();
    fetchNovels(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
        _onEndReached();
      }
    });
  }

  void fetchNovels(int page) {
    NovelBinService().getAllHotNovels(page).then((newNovels) {
      setState(() {
        allNovels.addAll(newNovels);
        novels = Future.value(allNovels);
      });
    });
  }

  void _onEndReached() {
    setState(() {
      isLoading = true; // Start loading
    });

    page++;
    fetchNovels(page);
    // After fetching, set isLoading to false in fetchNovels
    isLoading = false;
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _onEndReached();
          }
          return false;
        },
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: allNovels.length + (isLoading ? 1 : 0), // Add an extra item for loading indicator
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: .5,
                ),
                itemBuilder: (context, index) {
                  if (index == allNovels.length) {
                    return const Center(child: CircularProgressIndicator()); // Show loading indicator at the end
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
      ),
    );
  }
}
