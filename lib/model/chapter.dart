class Chapter {
  String? title;
  bool read = false;
  String link;
  String? content;
  String? date;
  String? next;
  String? previous;
  int? number;
  String? book;

  Chapter({
    this.title,
    this.content,
    this.next,
    this.previous,
    this.date,
    required this.link
});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      content: json["content"],
        link: json["link"],
      title: json["title"],
      next: json["next"],
      previous: json["prev"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "read" : read,
      "link" : link,
      "next" : next,
      "prev" : previous,
      "content" : content,
      "date" : date,
      "number" : number
    };
  }
}