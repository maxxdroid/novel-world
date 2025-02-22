import 'package:realm/realm.dart';

import '../model/realm_novel.dart';

import '../model/realm_chapter.dart';

class DownloadService {


  void saveNovel(Novel novel) {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    realm.write(() {
      realm.add(novel);
    });
  }

  getAllNovels() {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    return realm.all<Novel>();
  }

  /// Get a specific novel by title
  Novel? getNovelByTitle(String title) {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    return realm.find<Novel>(title);
  }

  /// Add a chapter to a novel
  void addChapterToNovel(String novelTitle, Chapter chapter) {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    final novel = realm.find<Novel>(novelTitle);
    if (novel != null) {
      realm.write(() {
        novel.chapters.add(chapter);
      });
    } else {
      print("Novel not found!");
    }
  }

  /// Update a chapter’s content in a novel
  void updateChapter(String novelTitle, String chapterLink, String newContent) {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    final novel = realm.find<Novel>(novelTitle);
    if (novel != null) {
      final chapter = novel.chapters.firstWhere(
            (c) => c.link == chapterLink,
        orElse: () => throw Exception("Chapter not found!"),
      );
      realm.write(() {
        chapter.content = newContent;
        chapter.downloaded = true; // Mark as downloaded
      });
    } else {
      print("Novel not found!");
    }
  }

  /// Delete a novel (and its chapters)
  void deleteNovel(String novelTitle) {
    var config = Configuration.local([Novel.schema]);
    var realm = Realm(config);
    final novel = realm.find<Novel>(novelTitle);
    if (novel != null) {
      realm.write(() {
        realm.delete(novel);
      });
    }
  }


}