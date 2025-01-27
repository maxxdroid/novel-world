import 'dart:ui';
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
  String? source;
  String? yearOfPublication;
  String? link;
  Color? color;
  String? lastUpdated;
  String? complete;
  String? type;
  String? latestChapter;
  String? latestChapterUrl;
  Chapter? lastReadChapter;
  List<Chapter>? chapters;

  Novel({
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

  // Convert a Color object to its integer representation for JSON serialization
  static int? colorToInt(Color? color) {
    return color?.value;
  }

  // Convert an integer back to a Color object when deserializing
  static Color? intToColor(int? colorInt) {
    if (colorInt == null) return null;
    return Color(colorInt);
  }

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json["title"] ?? '',
      description: json["description"],
      genres: json["genres"],
      link: json["link"] ?? '',
      lastReadChapter: json["lastReadChapter"] != null
          ? Chapter.fromJson(json["lastReadChapter"])
          : null,
      chapters: (json["chapters"] as List<dynamic>?)
          ?.map((item) {
        try {
          var chap = Chapter.fromJson(item as Map<String, dynamic>);
          if (chap.content != null) {
          }

          return chap;
        } catch (e) {
          print("Error decoding chapter: $item, Error: $e");
          return null;
        }
      }).whereType<Chapter>() // Filter out invalid chapters
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

    return other is Novel &&
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
  Novel copyWith({
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
    Chapter? lastReadChapter,
    List<Chapter>? chapters,
  }) {
    return Novel(
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
