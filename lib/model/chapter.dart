class Chapter {
  String? title;
  bool read;
  String link;
  String? content;
  String? date;
  String? next;
  String? previous;
  int number;
  String? book;

  Chapter({
    this.title,
    this.content,
    this.next,
    this.previous,
    this.date,
    required this.number,
    bool? read,
    required this.link
}) : read = read ?? false;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      content: json["content"],
        link: json["link"],
      title: json["title"],
      read: json["read"],
      next: json["next"],
      previous: json["prev"],
      number: json["number"]
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