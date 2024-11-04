import 'package:html/dom.dart';
import 'package:novel_world/model/chapter.dart';
import 'package:novel_world/model/novel.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class NovelBinService {

  static const String url = "https://novelbin.me/";

  static const String hotUrl = "https://novelbin.me/sort/novelbin-hot";

  Map<String, String> headers = {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.5',
    'Referer': url,
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
  };

  Future<List<Novel>> getHotNovels () async {
    List<Novel> hotNovels = [];

    try {
      // Make the HTTP request
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        // Parse the HTML response
        Document document = parse(response.body);

        // Select the elements that contain novel data
        List<Element> novels = document.querySelectorAll('.index-novel .item');

        for(Element novel in novels) {
          String title = novel.querySelector('h3')?.text ?? '';
          String link = novel.querySelector('a')?.attributes['href'] ?? '';
          String imageUrl = novel.querySelector('img')?.attributes['data-src'] ?? '';
          if (imageUrl.isEmpty) {
            imageUrl = novel.querySelector('img')?.attributes['src'] ?? '';
          }

          Novel hotNovel = Novel(title: title, link: link, imgUrl: imageUrl);

          hotNovels.add(hotNovel);
        }

      }else {
        throw Exception('Failed to load web page');
      }

    } catch (error) {
      print('An error has occurred: $error');
    }
    return hotNovels;
  }

  String revertImageUrl(String originalUrl) {
    return originalUrl.replaceAll('novel_200_89/', 'novel/');
  }

  Future<List<Novel>> getAllHotNovels(int page) async {
    List<Novel> hotNovels = [];// Set the URL accordingly

    try {
      // Make the HTTP request
      final response = await http.get(Uri.parse("$hotUrl?page=$page"));

      if (response.statusCode == 200) {
        // Parse the HTML response
        Document document = parse(response.body);

        // Select the novel list container
        List<Element> novels = document.querySelectorAll('.list.list-novel .row');

        for (Element novel in novels) {
          // Extract the title
          String title = novel.querySelector('.novel-title a')?.text.trim() ?? '';

          // Extract the link
          String link = novel.querySelector('.novel-title a')?.attributes['href'] ?? '';

          // Extract the image URL, prioritizing 'src' or 'data-src' attribute
          String imageUrl = novel.querySelector('.cover')?.attributes['data-src'] ??
              novel.querySelector('.cover')?.attributes['src'] ?? '';

          imageUrl = revertImageUrl(imageUrl);

          // Ensure non-empty title and link before adding to list
          if (title.isNotEmpty && link.isNotEmpty) {
            hotNovels.add(Novel(title: title, link: link, imgUrl: imageUrl));
          }
        }
      } else {
        throw Exception('Failed to load web page');
      }
    } catch (e) {
      print('Error fetching hot novels: $e');
    }

    return hotNovels;
  }


  Future<Novel?> getChapters (Novel novel) async {
    List<Chapter> allChapters = [];

    String chapterUrl = "${novel.link}#tab-chapters-title";

    try {
      // Make the HTTP request
      final response = await http.get(Uri.parse(chapterUrl), headers: headers);

      await Future.delayed(const Duration(milliseconds: 500));

      //Check if the response code is 200 and proceed
      if(response.statusCode == 200) {

        // Parse the HTML response
        Document doc = parse(response.body);

        // Extract chapter list
        Element? chapterList = doc.getElementById('list-chapter');
        List<Element> chapters =
            chapterList?.querySelectorAll('ul.list-chapter li a') ?? [];

        print('Size: ${chapters.length}');


        // Extract alternative names
        String alternativeNames = doc
            .querySelectorAll('li')
            .firstWhere((element) =>
            element.text.contains('Alternative names:'), orElse: () => Element.tag('li'))
            .text
            .replaceAll('Alternative names:', '')
            .trim();
        novel.alternativeNames = alternativeNames;

        // Extract author
        String author = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Author:'),
            orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.author = author;

        // Extract description
        String description = doc.querySelector('div.desc-text')?.text.trim() ?? '';
        novel.description = description;

        // Extract genres
        List<Element> genreElements = doc.querySelectorAll('li a');
        String genres = genreElements
            .where((element) => element.parent?.text.contains('Genre:') ?? false)
            .map((e) => e.text)
            .join(', ');
        novel.genres = genres;

        // Extract status
        String status = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Status:'),
            orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.status = status;

        // Extract publisher
        String publisher = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Publishers:'),
            orElse: () => Element.tag('li'))
            .text
            .replaceAll('Publishers:', '')
            .trim();
        novel.publisher = publisher;

        // Extract tags
        List<Element> tagElements = doc.querySelectorAll('div.tag-container a');
        String tags = tagElements.map((e) => e.text).join(', ');
        novel.tags = tags;

        // Extract year of publishing
        String yearOfPublishing = doc
            .querySelectorAll('li')
            .firstWhere((element) =>
            element.text.contains('Year of publishing:'), orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.yearOfPublication = yearOfPublishing;

        for (Element chapter in chapters) {
          String chapterTitle = chapter.text.trim();
          String chapterLink = chapter.attributes['href'] ?? '';

          // Add to list of chapters
          allChapters.add(Chapter(title: chapterTitle, link: chapterLink));
        }
        novel.chapters = allChapters;
        return novel;

      } else {
        throw Exception('Failed to load web page');
      }


    } catch (e) {
      print(e);
    }
    return null;

  }

  Future<Novel?> getChaptersFromDocument (Novel novel, Document doc) async {
    List<Chapter> allChapters = [];

    try {

        // Extract chapter list
        Element? chapterList = doc.getElementById('list-chapter');
        List<Element> chapters =
            chapterList?.querySelectorAll('ul.list-chapter li a') ?? [];

        print('Size: ${chapters.length}');


        // Extract alternative names
        String alternativeNames = doc
            .querySelectorAll('li')
            .firstWhere((element) =>
            element.text.contains('Alternative names:'), orElse: () => Element.tag('li'))
            .text
            .replaceAll('Alternative names:', '')
            .trim();
        novel.alternativeNames = alternativeNames;

        // Extract author
        String author = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Author:'),
            orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.author = author;

        // Extract description
        String description = doc.querySelector('div.desc-text')?.text.trim() ?? '';
        novel.description = description;

        // Extract genres
        List<Element> genreElements = doc.querySelectorAll('li a');
        String genres = genreElements
            .where((element) => element.parent?.text.contains('Genre:') ?? false)
            .map((e) => e.text)
            .join(', ');
        novel.genres = genres;

        // Extract status
        String status = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Status:'),
            orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.status = status;

        // Extract publisher
        String publisher = doc
            .querySelectorAll('li')
            .firstWhere((element) => element.text.contains('Publishers:'),
            orElse: () => Element.tag('li'))
            .text
            .replaceAll('Publishers:', '')
            .trim();
        novel.publisher = publisher;

        // Extract tags
        List<Element> tagElements = doc.querySelectorAll('div.tag-container a');
        String tags = tagElements.map((e) => e.text).join(', ');
        novel.tags = tags;

        // Extract year of publishing
        String yearOfPublishing = doc
            .querySelectorAll('li')
            .firstWhere((element) =>
            element.text.contains('Year of publishing:'), orElse: () => Element.tag('li'))
            .querySelector('a')
            ?.text ?? '';
        novel.yearOfPublication = yearOfPublishing;

        for (Element chapter in chapters) {
          String chapterTitle = chapter.text.trim();
          String chapterLink = chapter.attributes['href'] ?? '';

          // Add to list of chapters
          allChapters.add(Chapter(title: chapterTitle, link: chapterLink));
        }
        novel.chapters = allChapters;
        return novel;

    } catch (e) {
      print(e);
    }
    return null;

  }

  Future<Chapter> getChapterContent(Chapter chapter) async {
    try {
      final response = await http.get(Uri.parse(chapter.link));
      if (response.statusCode == 200) {
        Document document = parse(response.body);

        // Extract chapter title
        String chapterTitle = '';
        final anchorElement = document.querySelector('a.chr-title');
        if (anchorElement != null) {
          final spanElement = anchorElement.querySelector('span.chr-text');
          if (spanElement != null) {
            chapterTitle = spanElement.text.trim();
            print('Extracted Title: $chapterTitle');
          } else {
            print('Span element with class "chr-text" not found');
          }
        } else {
          print('Anchor element with class "chr-title" not found');
        }

        chapter.title = chapterTitle;

        // Extract chapter content
        final contentElement = document.getElementById('chr-content');
        if (contentElement == null) {
          throw Exception('Chapter content not found');
        }

        String chapterText = contentElement.innerHtml
            .replaceAll(RegExp(r'window\.pubfuturetag\s*=\s*.*?;'), '') // Removes inline scripts
            .replaceAll(RegExp(r'<script.*?>.*?</script>', dotAll: true), '') // Removes script tags
            .replaceAll('<p>', '\n') // Add new lines for each paragraph
            .replaceAll('</p>', '')
            .replaceAll(RegExp(r'<div[^>]*id="pf-\d+"[^>]*></div>'), '') // Removes specific empty divs with IDs like pf-4474-1
            .replaceAll(RegExp(r'<div[^>]*></div>'), '') // Removes any other empty divs
            .trim();

        chapter.content = chapterText;

        // Extract next chapter link
        final nextChapterElement = document.getElementById('next_chap');
        chapter.next = nextChapterElement?.attributes['href'];

        // Extract previous chapter link
        final prevChapterElement = document.getElementById('prev_chap');
        chapter.previous = prevChapterElement?.attributes['href'];

        return chapter;
      }
    } catch (e) {
      print("Error fetching chapter content: $e");
    }
    return chapter;
  }


}