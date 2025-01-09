import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:novel_world/model/novel.dart';

class NovelHiService {

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
        // Map<dynamic, dynamic> data = response.body.;
        // print("${data["data"]}");

        final jsonResponse = jsonDecode(response.body);

        final jsonNovels = jsonResponse["data"]["list"];

        for (var novel in jsonNovels) {
          String title = novel["bookName"];
          String link = novel["picUrl"];
          String imageUrl = novel["picUrl"];

          Novel newNovel = Novel(title: title, link: link, imgUrl: imageUrl);
          getNovels.add(newNovel);
        }

        print("${jsonResponse["data"]["list"]}");

      }

    } catch (e) {
      print(e);
    }
    
    return getNovels;
  }
  
}