// import 'package:get/get.dart';
//
// class NovelController extends GetxController {
//   // List to store novels
//   var novels = <Novel>[].obs;
//   var isLoading = false.obs;
//
//   // Fetch novels from the API
//   void fetchNovels() async {
//     isLoading(true);
//     try {
//       // Replace with actual fetching logic
//       var fetchedNovels = await NovelService.fetchNovels();
//       novels.assignAll(fetchedNovels);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Mark a novel as favorite
//   void toggleFavorite(Novel novel) {
//     novel.isFavorite = !novel.isFavorite;
//     novels.refresh(); // Notify UI of changes
//   }
// }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class NovelScreen extends StatelessWidget {
//   final NovelController novelController = Get.put(NovelController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Web Novels")),
//       body: Obx(() {
//         if (novelController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           itemCount: novelController.novels.length,
//           itemBuilder: (context, index) {
//             final novel = novelController.novels[index];
//             return ListTile(
//               title: Text(novel.title),
//               subtitle: Text(novel.author),
//               trailing: IconButton(
//                 icon: Icon(
//                   novel.isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: novel.isFavorite ? Colors.red : null,
//                 ),
//                 onPressed: () {
//                   novelController.toggleFavorite(novel);
//                 },
//               ),
//             );
//           },
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: novelController.fetchNovels,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
//
// import 'package:get_storage/get_storage.dart';
//
// class NovelController extends GetxController {
//   var novels = <Novel>[].obs;
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadFavorites();
//   }
//
//   void loadFavorites() {
//     novels.forEach((novel) {
//       novel.isFavorite = box.read(novel.title) ?? false;
//     });
//   }
//
//   void toggleFavorite(Novel novel) {
//     novel.isFavorite = !novel.isFavorite;
//     box.write(novel.title, novel.isFavorite);
//     novels.refresh();
//   }
// }
//
//
