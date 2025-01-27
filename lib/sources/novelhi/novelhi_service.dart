import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:novel_world/functions/novel_functions.dart';
import 'package:novel_world/model/chapter.dart';
import 'package:novel_world/model/novel.dart';

class NovelHiService {
  final NovelFunction novelFunction = NovelFunction();

  static const url = "https://novelhi.com/";
  Map<String, String> headers = {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.5',
    'Referer': url,
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
  };
  
  Future<List<Novel>> getNovels (int index) async {
    List<Novel> getNovels = [];
    
    try {
      
      final response = await http.get(Uri.parse("https://novelhi.com/book/searchByPageInShelf?curr=$index&limit=20&keyword="), headers: headers);

      if (response.statusCode == 200) {

        final jsonResponse = jsonDecode(response.body);

        final jsonNovels = jsonResponse["data"]["list"];

        for (var novel in jsonNovels) {
          String title = novel["bookName"];
          String desc = novel["bookDesc"];

          final genres = novel["genres"];

          String genreList = "";

          for(var genre in genres) {
            if (genreList == "" ) {
              genreList = "${genre["genreName"]}";
            } else {
              genreList = "$genreList, ${genre["genreName"]}";
            }
          }

          Novel newNovel = Novel(
            title: novel["bookName"],
            link: "${url}s/${title.replaceAll(" ", "-").replaceAll("'", "").replaceAll(":", "")}",
            imgUrl: novel["picUrl"],
            author: novel["authorName"],
            status: novel["bookStatus"] == '0' ? "completed" : "ongoing",
            description: desc.replaceAll("<br>", "\n"),
            genres: genreList,
            yearOfPublication: novel[""]
          );
          getNovels.add(newNovel);
        }

      }

    } catch (e) {
      print(e);
    }
    
    return getNovels;
  }

  Future<Novel> getChapters (Novel novel) async {
    List<Chapter> chapters = [];

    String url = novelFunction.getNovelHiUrl(novel.link ?? "");

    print(url);

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        // Log raw HTML for debugging
        if (kDebugMode) {
          print("HTML Content: ${response.body}");
        }

        // Parse the HTML response
        final Document doc = parse(response.body);

        // Extract chapter elements
        final List<Element> chapterElements = doc.querySelectorAll('.dirList ul li a span');

        if (chapterElements.isEmpty) {
          if (kDebugMode) {
            print("No chapters found. Check your selector or HTML structure.");
          }
        } else {
          // Extract chapter text
          for (final element in chapterElements) {
            final chapterText = element.text.trim();
            if (kDebugMode) {
              print("Chapter: $chapterText");
            }

            // Extract numbers using regex
            final match = RegExp(r'\d+').firstMatch(chapterText);
            final number = match != null ? int.parse(match.group(0)!) : null;
            if (kDebugMode) {
              print("Extracted Number: $number");
            }

            Chapter chapter =Chapter(
                number: number ?? 0,
                title: chapterText,
                link: "${novel.link}/$number"
            );
            chapters.add(chapter);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    novel.chapters = chapters;

    return novel;
  }

  Future<List<Novel>> searchNovels (String keyWords, int page) async {
    List<Novel> getNovels = [];

    try {

      final response = await http.get(Uri.parse("https://novelhi.com/book/searchByPageInShelf?curr=$page&limit=20&keyword=$keyWords"), headers: headers);

      if (response.statusCode == 200) {

        final jsonResponse = jsonDecode(response.body);

        final jsonNovels = jsonResponse["data"]["list"];

        for (var novel in jsonNovels) {
          String title = novel["bookName"];
          String desc = novel["bookDesc"];

          final genres = novel["genres"];

          String genreList = "";

          for(var genre in genres) {
            if (genreList == "" ) {
              genreList = "${genre["genreName"]}";
            } else {
              genreList = "$genreList, ${genre["genreName"]}";
            }
          }

          Novel newNovel = Novel(
              title: novel["bookName"],
              link: "${url}s/${title.replaceAll(" ", "-")}",
              imgUrl: novel["picUrl"],
              author: novel["authorName"],
              status: novel["bookStatus"] == '0' ? "completed" : "ongoing",
              description: desc.replaceAll("<br>", "\n"),
              genres: genreList,
              yearOfPublication: novel[""]
          );
          getNovels.add(newNovel);
        }
      }

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return getNovels;
  }
  
}