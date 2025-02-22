// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_novel.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Novel extends _Novel with RealmEntity, RealmObjectBase, RealmObject {
  Novel(
    String link,
    String title,
    String imgUrl,
    String author, {
    String? alternativeNames,
    String? description,
    String? genres,
    String? status,
    String? publisher,
    String? tags,
    String? source,
    String? yearOfPublication,
    String? lastUpdated,
    String? complete,
    String? type,
    String? latestChapter,
    String? latestChapterUrl,
    Chapter? lastReadChapter,
    Iterable<Chapter> chapters = const [],
  }) {
    RealmObjectBase.set(this, 'link', link);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'imgUrl', imgUrl);
    RealmObjectBase.set(this, 'author', author);
    RealmObjectBase.set(this, 'alternativeNames', alternativeNames);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'genres', genres);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'publisher', publisher);
    RealmObjectBase.set(this, 'tags', tags);
    RealmObjectBase.set(this, 'source', source);
    RealmObjectBase.set(this, 'yearOfPublication', yearOfPublication);
    RealmObjectBase.set(this, 'lastUpdated', lastUpdated);
    RealmObjectBase.set(this, 'complete', complete);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'latestChapter', latestChapter);
    RealmObjectBase.set(this, 'latestChapterUrl', latestChapterUrl);
    RealmObjectBase.set(this, 'lastReadChapter', lastReadChapter);
    RealmObjectBase.set<RealmList<Chapter>>(
        this, 'chapters', RealmList<Chapter>(chapters));
  }

  Novel._();

  @override
  String get link => RealmObjectBase.get<String>(this, 'link') as String;
  @override
  set link(String value) => RealmObjectBase.set(this, 'link', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get imgUrl => RealmObjectBase.get<String>(this, 'imgUrl') as String;
  @override
  set imgUrl(String value) => RealmObjectBase.set(this, 'imgUrl', value);

  @override
  String get author => RealmObjectBase.get<String>(this, 'author') as String;
  @override
  set author(String value) => RealmObjectBase.set(this, 'author', value);

  @override
  String? get alternativeNames =>
      RealmObjectBase.get<String>(this, 'alternativeNames') as String?;
  @override
  set alternativeNames(String? value) =>
      RealmObjectBase.set(this, 'alternativeNames', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get genres => RealmObjectBase.get<String>(this, 'genres') as String?;
  @override
  set genres(String? value) => RealmObjectBase.set(this, 'genres', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  String? get publisher =>
      RealmObjectBase.get<String>(this, 'publisher') as String?;
  @override
  set publisher(String? value) => RealmObjectBase.set(this, 'publisher', value);

  @override
  String? get tags => RealmObjectBase.get<String>(this, 'tags') as String?;
  @override
  set tags(String? value) => RealmObjectBase.set(this, 'tags', value);

  @override
  String? get source => RealmObjectBase.get<String>(this, 'source') as String?;
  @override
  set source(String? value) => RealmObjectBase.set(this, 'source', value);

  @override
  String? get yearOfPublication =>
      RealmObjectBase.get<String>(this, 'yearOfPublication') as String?;
  @override
  set yearOfPublication(String? value) =>
      RealmObjectBase.set(this, 'yearOfPublication', value);

  @override
  String? get lastUpdated =>
      RealmObjectBase.get<String>(this, 'lastUpdated') as String?;
  @override
  set lastUpdated(String? value) =>
      RealmObjectBase.set(this, 'lastUpdated', value);

  @override
  String? get complete =>
      RealmObjectBase.get<String>(this, 'complete') as String?;
  @override
  set complete(String? value) => RealmObjectBase.set(this, 'complete', value);

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  String? get latestChapter =>
      RealmObjectBase.get<String>(this, 'latestChapter') as String?;
  @override
  set latestChapter(String? value) =>
      RealmObjectBase.set(this, 'latestChapter', value);

  @override
  String? get latestChapterUrl =>
      RealmObjectBase.get<String>(this, 'latestChapterUrl') as String?;
  @override
  set latestChapterUrl(String? value) =>
      RealmObjectBase.set(this, 'latestChapterUrl', value);

  @override
  Chapter? get lastReadChapter =>
      RealmObjectBase.get<Chapter>(this, 'lastReadChapter') as Chapter?;
  @override
  set lastReadChapter(covariant Chapter? value) =>
      RealmObjectBase.set(this, 'lastReadChapter', value);

  @override
  RealmList<Chapter> get chapters =>
      RealmObjectBase.get<Chapter>(this, 'chapters') as RealmList<Chapter>;
  @override
  set chapters(covariant RealmList<Chapter> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Novel>> get changes =>
      RealmObjectBase.getChanges<Novel>(this);

  @override
  Stream<RealmObjectChanges<Novel>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Novel>(this, keyPaths);

  @override
  Novel freeze() => RealmObjectBase.freezeObject<Novel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'link': link.toEJson(),
      'title': title.toEJson(),
      'imgUrl': imgUrl.toEJson(),
      'author': author.toEJson(),
      'alternativeNames': alternativeNames.toEJson(),
      'description': description.toEJson(),
      'genres': genres.toEJson(),
      'status': status.toEJson(),
      'publisher': publisher.toEJson(),
      'tags': tags.toEJson(),
      'source': source.toEJson(),
      'yearOfPublication': yearOfPublication.toEJson(),
      'lastUpdated': lastUpdated.toEJson(),
      'complete': complete.toEJson(),
      'type': type.toEJson(),
      'latestChapter': latestChapter.toEJson(),
      'latestChapterUrl': latestChapterUrl.toEJson(),
      'lastReadChapter': lastReadChapter.toEJson(),
      'chapters': chapters.toEJson(),
    };
  }

  static EJsonValue _toEJson(Novel value) => value.toEJson();
  static Novel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'link': EJsonValue link,
        'title': EJsonValue title,
        'imgUrl': EJsonValue imgUrl,
        'author': EJsonValue author,
      } =>
        Novel(
          fromEJson(link),
          fromEJson(title),
          fromEJson(imgUrl),
          fromEJson(author),
          alternativeNames: fromEJson(ejson['alternativeNames']),
          description: fromEJson(ejson['description']),
          genres: fromEJson(ejson['genres']),
          status: fromEJson(ejson['status']),
          publisher: fromEJson(ejson['publisher']),
          tags: fromEJson(ejson['tags']),
          source: fromEJson(ejson['source']),
          yearOfPublication: fromEJson(ejson['yearOfPublication']),
          lastUpdated: fromEJson(ejson['lastUpdated']),
          complete: fromEJson(ejson['complete']),
          type: fromEJson(ejson['type']),
          latestChapter: fromEJson(ejson['latestChapter']),
          latestChapterUrl: fromEJson(ejson['latestChapterUrl']),
          lastReadChapter: fromEJson(ejson['lastReadChapter']),
          chapters: fromEJson(ejson['chapters']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Novel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Novel, 'Novel', [
      SchemaProperty('link', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('imgUrl', RealmPropertyType.string),
      SchemaProperty('author', RealmPropertyType.string),
      SchemaProperty('alternativeNames', RealmPropertyType.string,
          optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('genres', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('publisher', RealmPropertyType.string, optional: true),
      SchemaProperty('tags', RealmPropertyType.string, optional: true),
      SchemaProperty('source', RealmPropertyType.string, optional: true),
      SchemaProperty('yearOfPublication', RealmPropertyType.string,
          optional: true),
      SchemaProperty('lastUpdated', RealmPropertyType.string, optional: true),
      SchemaProperty('complete', RealmPropertyType.string, optional: true),
      SchemaProperty('type', RealmPropertyType.string, optional: true),
      SchemaProperty('latestChapter', RealmPropertyType.string, optional: true),
      SchemaProperty('latestChapterUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('lastReadChapter', RealmPropertyType.object,
          optional: true, linkTarget: 'Chapter'),
      SchemaProperty('chapters', RealmPropertyType.object,
          linkTarget: 'Chapter', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
