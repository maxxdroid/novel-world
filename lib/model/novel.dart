import 'dart:ui';
import 'package:novel_world/model/chapter.dart';
import 'package:novel_world/model/realm_novel.dart';

class NovelModel {
  String? title;
  String? imgUrl;
  String? author;
  String? alternativeNames;
  String? description;
  String? genres;
  String? status;
  String? publisher;
  String? tags;
  String? source;
  String? yearOfPublication;
  String? link;
  Color? color;
  String? lastUpdated;
  String? complete;
  String? type;
  String? latestChapter;
  String? latestChapterUrl;
  ChapterModel? lastReadChapter;
  List<ChapterModel>? chapters;

  NovelModel({
    this.title,
    this.imgUrl,
    this.author,
    this.alternativeNames,
    this.description,
    this.genres,
    this.status,
    this.publisher,
    this.tags,
    this.source,
    this.yearOfPublication,
    this.link,
    this.color,
    this.lastUpdated,
    this.complete,
    this.type,
    this.latestChapter,
    this.latestChapterUrl,
    this.lastReadChapter,
    this.chapters,
  });

  Novel getNovel () {
    return Novel(
        link ?? "",
        title ?? "",
        imgUrl ?? "",
        author ?? "",
      alternativeNames:  alternativeNames,
      description:  description,
      genres:  genres,
      status:  status,
      publisher:  publisher,
      complete: complete,
      source: source,
      tags: tags,
      yearOfPublication: yearOfPublication,
      lastUpdated: lastUpdated,
      type: type,
      latestChapter: latestChapter,
      latestChapterUrl: latestChapterUrl,
      lastReadChapter: lastReadChapter?.getChapter(),
      chapters: chapters?.map((chap) => chap.getChapter()).toList() ?? []
    );
  }

  // Convert a Color object to its integer representation for JSON serialization
  static int? colorToInt(Color? color) {
    return color?.value;
  }

  // Convert an integer back to a Color object when deserializing
  static Color? intToColor(int? colorInt) {
    if (colorInt == null) return null;
    return Color(colorInt);
  }

  factory NovelModel.fromJson(Map<String, dynamic> json) {
    return NovelModel(
      title: json["title"] ?? '',
      description: json["description"],
      genres: json["genres"],
      link: json["link"] ?? '',
      lastReadChapter: json["lastReadChapter"] != null
          ? ChapterModel.fromJson(json["lastReadChapter"])
          : null,
      chapters: (json["chapters"] as List<dynamic>?)
          ?.map((item) {
        try {
          var chap = ChapterModel.fromJson(item as Map<String, dynamic>);
          if (chap.content != null) {
          }

          return chap;
        } catch (e) {
          print("Error decoding chapter: $item, Error: $e");
          return null;
        }
      }).whereType<ChapterModel>() // Filter out invalid chapters
          .toList(),
      imgUrl: json["imgUrl"] ?? '',
      color: intToColor(json["color"]),
      author: json["author"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "imgUrl": imgUrl,
      "link": link,
      "genres": genres,
      "source": source,
      "description": description,
      "lastReadChapter": lastReadChapter?.toJson(),
      "author": author,
      "color": colorToInt(color),
      "chapters": chapters?.map((chap) => chap.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NovelModel &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.source == source &&
        other.link == link;
  }

  @override
  int get hashCode {
    return title.hashCode ^ imgUrl.hashCode ^ link.hashCode;
  }

  // CopyWith Method
  NovelModel copyWith({
    String? title,
    String? imgUrl,
    String? author,
    String? alternativeNames,
    String? description,
    String? genres,
    String? status,
    String? publisher,
    String? tags,
    String? source,
    String? yearOfPublication,
    String? link,
    Color? color,
    String? lastUpdated,
    String? complete,
    String? type,
    String? latestChapter,
    String? latestChapterUrl,
    ChapterModel? lastReadChapter,
    List<ChapterModel>? chapters,
  }) {
    return NovelModel(
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      author: author ?? this.author,
      alternativeNames: alternativeNames ?? this.alternativeNames,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      status: status ?? this.status,
      source: source ?? this.source,
      publisher: publisher ?? this.publisher,
      tags: tags ?? this.tags,
      yearOfPublication: yearOfPublication ?? this.yearOfPublication,
      link: link ?? this.link,
      color: color ?? this.color,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      complete: complete ?? this.complete,
      type: type ?? this.type,
      latestChapter: latestChapter ?? this.latestChapter,
      latestChapterUrl: latestChapterUrl ?? this.latestChapterUrl,
      lastReadChapter: lastReadChapter ?? this.lastReadChapter,
      chapters: chapters ?? this.chapters,
    );
  }
}
