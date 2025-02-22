import 'package:realm/realm.dart';
part 'realm_chapter.realm.dart';

@RealmModel()
class $Chapter {
  @PrimaryKey()
  late String link; // Unique identifier

  late String title;
  late bool read;
  late String? content;
  late String? date;
  late String? next;
  late String? previous;
  late int number;
  late String? book;
  late bool downloaded;

}
