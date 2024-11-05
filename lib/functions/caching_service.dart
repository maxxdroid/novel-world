import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/novel.dart';

class CachingService {

  Future<void>  saveNovelBinHomeNovels (List<Novel> novels) async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = novels.map((novel) => jsonEncode(novel.toJson())).toList();
    print("................${novelList}");
    await prefs.setStringList("novelBin", novelList);
  }

  Future<List<Novel>> getNovelBinHomeNovels() async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = prefs.getStringList('novelBin') ?? [];
    return novelList.map((json) => Novel.fromJson(jsonDecode(json))).toList();
  }

  Future<void>  saveToLibrary (List<Novel> novels) async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = novels.map((novel) => jsonEncode(novel.toJson())).toList();
    await prefs.setStringList("MyLibrary", novelList);
  }

  Future<List<Novel>> getLibraryNovels() async {
    final prefs = await SharedPreferences.getInstance();
    final novelList = prefs.getStringList('MyLibrary') ?? [];
    return novelList.map((json) => Novel.fromJson(jsonDecode(json))).toList();
  }

}