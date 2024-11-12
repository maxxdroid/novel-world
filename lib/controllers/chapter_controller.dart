import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:novel_world/functions/caching_service.dart';
import 'package:novel_world/model/novel.dart';
import 'package:novel_world/novelbin/novelbin_service.dart';

import '../model/chapter.dart';
import 'library_controller.dart';

class ChapterController extends GetxController {

  final NovelBinService novelBinService = NovelBinService();
  final CachingService cachingService = CachingService();

  // Fetch LibraryController instance
  final LibraryController libraryController = Get.find<LibraryController>();


  Future<void> downloadNovel (Novel novel) async {
    for (Chapter chapter in novel.chapters!) {
      chapter = await novelBinService.getChapterContent(chapter);
      novel.chapters?[chapter.number] = chapter;
    }
    libraryController.updateLibraryNovel(novel);
  }

}