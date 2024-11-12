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
  String? yearOfPublication;
  String? link;
  Color? color;
  String? lastUpdated;
  String? complete;
  String? type;
  String? latestChapter;
  String? latestChapterUrl;
  List<Chapter>? chapters;

  Novel({
    this.chapters,
    this.author,
    this.color,
    this.description,
    this.genres,
    required this.title,
    required this.link,
    required this.imgUrl,
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
      title: json["title"],
      description: json["description"],
      genres: json["genres"],
      link: json["link"],
      chapters: (json["chapters"] as List<dynamic>?)
          ?.map((item) => Chapter.fromJson(item as Map<String, dynamic>))
          .toList(),
      imgUrl: json["imgUrl"],
      color: intToColor(json["color"]), // Convert integer back to Color
      author: json["author"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "imgUrl": imgUrl,
      "link": link,
      "genres": genres,
      "description": description,
      "author": author,
      "color": colorToInt(color), // Convert Color to integer
      "chapters": chapters?.map((chap) => chap.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Novel &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.link == link;
  }

  @override
  int get hashCode {
    return title.hashCode ^ imgUrl.hashCode ^ link.hashCode;
  }
}
