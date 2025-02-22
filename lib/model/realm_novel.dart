import 'package:novel_world/model/realm_chapter.dart';
import 'package:realm/realm.dart';
part 'realm_novel.realm.dart';

@RealmModel()
class _Novel {
  @PrimaryKey()
  late String link; // Unique identifier

  late String title;
  late String imgUrl;
  late String author;
  late String? alternativeNames;
  late String? description;
  late String? genres;
  late String? status;
  late String? publisher;
  late String? tags;
  late String? source;
  late String? yearOfPublication;
  late String? lastUpdated;
  late String? complete;
  late String? type;
  late String? latestChapter;
  late String? latestChapterUrl;
  late $Chapter? lastReadChapter; // Linking to chapters
  late List<$Chapter> chapters;
}

