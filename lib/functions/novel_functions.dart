

import '../model/chapter.dart';
import '../model/novel.dart';

class NovelFunction {

  String getNovelHiUrl(String url) {
    Uri uri = Uri.parse(url);

    // Modify the path
    String modifiedPath = uri.path.replaceFirst('/s/', '/s/index/');

    // Build the new URI
    Uri modifiedUri = uri.replace(path: modifiedPath);

    // Get the new URL as a string
    return modifiedUri.toString();
  }


  Novel updateNovelWithChanges(Novel oldNovel, Novel newNovel) {
    // Update fields only if they have new values in the newNovel
    return oldNovel.copyWith(
      title: newNovel.title != null && newNovel.title != oldNovel.title
          ? newNovel.title
          : null,
      imgUrl: newNovel.imgUrl != null && newNovel.imgUrl != oldNovel.imgUrl
          ? newNovel.imgUrl
          : null,
      author: newNovel.author != null && newNovel.author != oldNovel.author
          ? newNovel.author
          : null,
      alternativeNames: newNovel.alternativeNames != null &&
          newNovel.alternativeNames != oldNovel.alternativeNames
          ? newNovel.alternativeNames
          : null,
      description: newNovel.description != null &&
          newNovel.description != oldNovel.description
          ? newNovel.description
          : null,
      genres: newNovel.genres != null && newNovel.genres != oldNovel.genres
          ? newNovel.genres
          : null,
      status: newNovel.status != null && newNovel.status != oldNovel.status
          ? newNovel.status
          : null,
      publisher: newNovel.publisher != null &&
          newNovel.publisher != oldNovel.publisher
          ? newNovel.publisher
          : null,
      tags: newNovel.tags != null && newNovel.tags != oldNovel.tags
          ? newNovel.tags
          : null,
      yearOfPublication: newNovel.yearOfPublication != null &&
          newNovel.yearOfPublication != oldNovel.yearOfPublication
          ? newNovel.yearOfPublication
          : null,
      link: newNovel.link != null && newNovel.link != oldNovel.link
          ? newNovel.link
          : null,
      color: newNovel.color != null && newNovel.color != oldNovel.color
          ? newNovel.color
          : null,
      lastUpdated: newNovel.lastUpdated != null &&
          newNovel.lastUpdated != oldNovel.lastUpdated
          ? newNovel.lastUpdated
          : null,
      complete: newNovel.complete != null && newNovel.complete != oldNovel.complete
          ? newNovel.complete
          : null,
      type: newNovel.type != null && newNovel.type != oldNovel.type
          ? newNovel.type
          : null,
      latestChapter: newNovel.latestChapter != null &&
          newNovel.latestChapter != oldNovel.latestChapter
          ? newNovel.latestChapter
          : null,
      latestChapterUrl: newNovel.latestChapterUrl != null &&
          newNovel.latestChapterUrl != oldNovel.latestChapterUrl
          ? newNovel.latestChapterUrl
          : null,
      lastReadChapter: newNovel.lastReadChapter != null &&
          newNovel.lastReadChapter != oldNovel.lastReadChapter
          ? newNovel.lastReadChapter
          : null,
      // Update chapters, retaining existing ones and adding only new ones
      chapters: mergeChapters(oldNovel.chapters, newNovel.chapters),
    );
  }

// Helper function to merge chapters
  List<Chapter>? mergeChapters(List<Chapter>? oldChapters, List<Chapter>? newChapters) {
    if (newChapters == null) return oldChapters; // Return old list if no new chapters
    if (oldChapters == null) return newChapters; // Return new list if no old chapters

    // Map old chapters by their unique 'link' for fast lookup
    final Map<String, Chapter> oldChapterMap = {
      for (var chapter in oldChapters) chapter.link: chapter
    };

    for (var newChapter in newChapters) {
      if (newChapter.link.isNotEmpty) {
        if (oldChapterMap.containsKey(newChapter.link)) {
          // Update existing chapter fields if new values are provided
          final existingChapter = oldChapterMap[newChapter.link]!;
          oldChapterMap[newChapter.link] = Chapter(
            link: existingChapter.link, // Link remains constant
            number: existingChapter.number, // Number remains constant
            title: newChapter.title ?? existingChapter.title,
            content: newChapter.content ?? existingChapter.content,
            read: newChapter.read, // Update read status directly
            date: newChapter.date ?? existingChapter.date,
            next: newChapter.next ?? existingChapter.next,
            previous: newChapter.previous ?? existingChapter.previous,
            book: newChapter.book ?? existingChapter.book,
          );
        } else {
          // Add new chapter if not present in the old list
          oldChapterMap[newChapter.link] = newChapter;
        }
      }
    }

    // Return updated list of chapters
    return oldChapterMap.values.toList()
      ..sort((a, b) => a.number.compareTo(b.number)); // Ensure chapters are sorted by 'number'
  }

}