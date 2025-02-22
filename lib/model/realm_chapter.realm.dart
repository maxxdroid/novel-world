// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_chapter.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Chapter extends $Chapter with RealmEntity, RealmObjectBase, RealmObject {
  Chapter(
    String link,
    String title,
    bool read,
    int number,
    bool downloaded, {
    String? content,
    String? date,
    String? next,
    String? previous,
    String? book,
  }) {
    RealmObjectBase.set(this, 'link', link);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'read', read);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'next', next);
    RealmObjectBase.set(this, 'previous', previous);
    RealmObjectBase.set(this, 'number', number);
    RealmObjectBase.set(this, 'book', book);
    RealmObjectBase.set(this, 'downloaded', downloaded);
  }

  Chapter._();

  @override
  String get link => RealmObjectBase.get<String>(this, 'link') as String;
  @override
  set link(String value) => RealmObjectBase.set(this, 'link', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  bool get read => RealmObjectBase.get<bool>(this, 'read') as bool;
  @override
  set read(bool value) => RealmObjectBase.set(this, 'read', value);

  @override
  String? get content =>
      RealmObjectBase.get<String>(this, 'content') as String?;
  @override
  set content(String? value) => RealmObjectBase.set(this, 'content', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get next => RealmObjectBase.get<String>(this, 'next') as String?;
  @override
  set next(String? value) => RealmObjectBase.set(this, 'next', value);

  @override
  String? get previous =>
      RealmObjectBase.get<String>(this, 'previous') as String?;
  @override
  set previous(String? value) => RealmObjectBase.set(this, 'previous', value);

  @override
  int get number => RealmObjectBase.get<int>(this, 'number') as int;
  @override
  set number(int value) => RealmObjectBase.set(this, 'number', value);

  @override
  String? get book => RealmObjectBase.get<String>(this, 'book') as String?;
  @override
  set book(String? value) => RealmObjectBase.set(this, 'book', value);

  @override
  bool get downloaded => RealmObjectBase.get<bool>(this, 'downloaded') as bool;
  @override
  set downloaded(bool value) => RealmObjectBase.set(this, 'downloaded', value);

  @override
  Stream<RealmObjectChanges<Chapter>> get changes =>
      RealmObjectBase.getChanges<Chapter>(this);

  @override
  Stream<RealmObjectChanges<Chapter>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Chapter>(this, keyPaths);

  @override
  Chapter freeze() => RealmObjectBase.freezeObject<Chapter>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'link': link.toEJson(),
      'title': title.toEJson(),
      'read': read.toEJson(),
      'content': content.toEJson(),
      'date': date.toEJson(),
      'next': next.toEJson(),
      'previous': previous.toEJson(),
      'number': number.toEJson(),
      'book': book.toEJson(),
      'downloaded': downloaded.toEJson(),
    };
  }

  static EJsonValue _toEJson(Chapter value) => value.toEJson();
  static Chapter _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'link': EJsonValue link,
        'title': EJsonValue title,
        'read': EJsonValue read,
        'number': EJsonValue number,
        'downloaded': EJsonValue downloaded,
      } =>
        Chapter(
          fromEJson(link),
          fromEJson(title),
          fromEJson(read),
          fromEJson(number),
          fromEJson(downloaded),
          content: fromEJson(ejson['content']),
          date: fromEJson(ejson['date']),
          next: fromEJson(ejson['next']),
          previous: fromEJson(ejson['previous']),
          book: fromEJson(ejson['book']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Chapter._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Chapter, 'Chapter', [
      SchemaProperty('link', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('read', RealmPropertyType.bool),
      SchemaProperty('content', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('next', RealmPropertyType.string, optional: true),
      SchemaProperty('previous', RealmPropertyType.string, optional: true),
      SchemaProperty('number', RealmPropertyType.int),
      SchemaProperty('book', RealmPropertyType.string, optional: true),
      SchemaProperty('downloaded', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
