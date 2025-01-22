import 'package:get/get.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/sources/novelbin/novelbin_service.dart';

import '../model/chapter.dart';
import 'library_controller.dart';

class ChapterController extends GetxController {

  final NovelBinService novelBinService = NovelBinService();
  final CachingService cachingService = CachingService();

  // Fetch LibraryController instance
  final LibraryController libraryController = Get.find<LibraryController>();

  Future<void> downloadNovel (Novel novel) async {
    for (Chapter chapter in novel.chapters!) {
      if(chapter.content == null) {
        chapter = await novelBinService.getChapterContent(novel.chapters![chapter.number]);
        novel.chapters?[chapter.number] = chapter;
        libraryController.updateLibraryNovel(novel);
      }
    }
    Get.snackbar("${novel.title}", "Download Complete!");
  }

}
