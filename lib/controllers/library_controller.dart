import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/functions/novel_functions.dart';
import 'package:novel_world/model/novel.dart';

import '../tabs/home_tabs.dart';

class LibraryController extends GetxController {
  final GlobalKey<HomeTabsState> homeTabsKey = GlobalKey<HomeTabsState>();
  final NovelFunction func = NovelFunction();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLibraryNovels();
    if(novels.isEmpty) homeTabsKey.currentState?.navigateToPage(2);
  }

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    fetchLibraryNovels();
  }

  var novels = <Novel>[].obs;
  var isLoading = true.obs;

  void fetchLibraryNovels() async {
    isLoading(true);
    try {
      var libraryNovels = await CachingService().getLibraryNovels();
      novels.assignAll(libraryNovels);
    } finally {
      isLoading(false);
    }
  }

  void updateLibraryNovel(Novel updatedNovel) async {
    // Find the index of the existing novel with the same title
    int index = novels.indexWhere((novel) => novel.title == updatedNovel.title);
    print("...............Updated.................");


    if (index != -1) {
      //Saving only the changed aspects
      var newNovel = func.updateNovelWithChanges(novels[index], updatedNovel);
      // Replace the existing novel with the updated novel
      novels[index] = newNovel;
      print("${newNovel.toJson()}");
      // Get.snackbar("Info", "novel updated");
      saveNovelsInLibrary();  // Save the updated list to SharedPreferences
    } else {
      // Optionally, show a message if the novel was not found in the library
      Get.snackbar("Info", "The novel is not in your library");
    }
  }


  bool novelInLibrary(Novel novel) {
    if (novels.any((existingNovel) => existingNovel.title == novel.title)) {
      return true;
    }
    return false;
  }

  void saveNovelsInLibrary() async {
    await CachingService().saveToLibrary(novels);
    fetchLibraryNovels();
  }

  void addToLibrary(Novel novel) {
    // Check if a novel with the same title already exists in the library
    if (!novels.any((existingNovel) => existingNovel.title == novel.title)) {
      novels.add(novel);
      saveNovelsInLibrary();
    } else {
      // Optionally, show a message if the novel is already in the library
      Get.snackbar("Info", "This novel is already in your library");
    }
  }

  void removeFromLibrary(Novel novel) {
    if(novels.any((existingNovel) => existingNovel.title == novel.title)) {
      novels.remove(novel);
      saveNovelsInLibrary();
    } else {
      // Optionally, show a message if the novel is already in the library
      Get.snackbar("Info", "This novel is not in your library");
    }
  }
}