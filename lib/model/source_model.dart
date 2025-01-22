import 'dart:ui';

class SourceModel {
  String url;
  String name;
  String icon;
  String? banner;
  VoidCallback onTap;

  SourceModel({
    required this.url,
    required this.name,
    required this.icon,
    required this.onTap,
    this.banner
});
}