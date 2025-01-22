import 'package:novel_world/model/source_model.dart';
import 'package:get/get.dart';
import 'package:novel_world/sources/novelbin/novel_bin_home.dart';

import '../sources/novelhi/novelhi_home.dart';

List<SourceModel> sources = [
  SourceModel(
      url: "https://novelbin.me/",
      name: "NovelBin",
      icon: "assets/images/novelbin-logo.png",
      banner: "assets/images/novelbin-icon.png",
      onTap: () {
        Get.to(() => const NovelBinHome());
      }
  ),
  SourceModel(
      url: "https://novelhi.com/",
      name: "NovelHi",
      icon: "assets/images/novelhi-icon.png",
      banner: "assets/images/novelhi-logo.png",
      onTap: () {
        Get.to(() => const NovelHiHome());
      }
  ),
  SourceModel(
      url: "",
      name: "NovelCool",
      icon: "assets/images/novelbin-logo.png",
      onTap: () {
      }
  ),
];