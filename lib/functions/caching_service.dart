import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/novel.dart';

class CachingService {

  Future<void>  saveNovelBinHomeNovels (List<NovelModel> novels) async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = novels.map((novel) => jsonEncode(novel.toJson())).toList();
    await prefs.setStringList("novelBin", novelList);
  }

  Future<List<NovelModel>> getNovelBinHomeNovels() async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = prefs.getStringList('novelBin') ?? [];
    return novelList.map((json) => NovelModel.fromJson(jsonDecode(json))).toList();
  }

  Future<void>  saveToLibrary (List<NovelModel> novels) async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = novels.map((novel) => jsonEncode(novel.toJson())).toList();
    await prefs.setStringList("MyLibrary", novelList);
  }

  Future<List<NovelModel>> getLibraryNovels() async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = prefs.getStringList('MyLibrary') ?? [];
    return novelList.map((json) => NovelModel.fromJson(jsonDecode(json))).toList();
  }

}