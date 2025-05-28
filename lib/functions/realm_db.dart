import 'package:get/get.dart';
import 'package:novel_world/model/realm_novel.dart';
import 'package:realm/realm.dart';

class RealmDB extends GetxController {
  late final Realm realm;

  @override
  void onInit() {
    final config = Configuration.local([Novel.schema]);
    realm = Realm(config);
    super.onInit();
  }

  // Save novels to Realm
  Future<void> saveToLibrary(List<Novel> novels) async {
    realm.write(() {
      for (final novel in novels) {
        realm.add(novel, update: true);
      }
    });
  }

  // Get all novels from Realm
  Future<List<Novel>> getLibraryNovels() async {
    final novels = realm.all<Novel>();
    return novels.toList();
  }

  // Optionally add a clear method
  Future<void> clearLibrary() async {
    realm.write(() {
      realm.deleteMany(realm.all<Novel>());
    });
  }

  @override
  void onClose() {
    realm.close();
    super.onClose();
  }
}
