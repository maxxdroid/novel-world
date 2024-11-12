import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_world/controllers/library_controller.dart';

import '../pages/novel_details.dart';

class MyLibrary extends StatefulWidget {
  const MyLibrary({super.key});

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  final LibraryController libraryController = Get.put(LibraryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Library", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if(libraryController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Flexible(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: libraryController.novels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: .5,
                ),
                itemBuilder: (context, index) {

                  final novel = libraryController.novels[index];
                  return GestureDetector(
                    onTap: () {
                      if(novel.link == null) {
                        print("Hola");
                      } else {
                        // print("novel Details::${novel.toJson()}");
                        Get.to(() => NovelDetails(novel: novel));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.grey.shade50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(novel.imgUrl ?? "", height: 160, fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: Text(novel.title ?? "", overflow: TextOverflow.fade, textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
