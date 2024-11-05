import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/model/novel.dart';

class LibraryController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLibraryNovels();
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
      var libraryNovels = await CachingService().getNovelBinHomeNovels();
      novels.assignAll(libraryNovels);
    } finally {
      isLoading(false);
    }
  }

  void saveNovelsInLibrary() async {
    await CachingService().saveToLibrary(novels);
    fetchLibraryNovels();
  }

  void addToLibrary(Novel novel) {
    novels.add(novel);
    saveNovelsInLibrary();
  }

  void removeFromLibrary(Novel novel) {
    novels.remove(novel);
    saveNovelsInLibrary();
  }
}