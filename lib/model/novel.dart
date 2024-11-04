import 'package:novel_world/model/chapter.dart';

class Novel {
  String? title;
  String? imgUrl;
  String? author;
  String? alternativeNames;
  String? description;
  String? genres;
  String? status;
  String? publisher;
  String? tags;
  String? yearOfPublication;
  String? link;
  String? lastUpdated;
  String? complete;
  String? type;
  String? latestChapter;
  String? latestChapterUrl;
  List<Chapter>? chapters;

  Novel({
    this.chapters,
    this.author,
    required this.title,
    required this.link,
    required this.imgUrl
});

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
        title: json["title"],
        link: json["link"],
        chapters: (json["chapters"] as List<dynamic>)
            .map((item) => Chapter.fromJson(item as Map<String, dynamic>)).toList(),
        imgUrl: json["imgUrl"],
        author: json["author"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "imgUrl" : imgUrl,
      "author" : author,
      "chapters" : chapters?.map((chap) => chap.toJson()).toList(),
    };
  }
}