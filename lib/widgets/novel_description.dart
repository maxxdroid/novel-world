import 'package:flutter/material.dart';
import 'package:novel_world/model/novel.dart';

import '../model/realm_novel.dart';

class NovelDescription extends StatelessWidget {
  final Novel novel;
  final bool inLibrary;
  final VoidCallback onTap;
  const NovelDescription({super.key, required this.novel, required this.inLibrary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: width,// Fixed height when collapsed
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text(
                    novel.description ?? "",),
                  const Text(
                    "Tags",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, // Horizontal space between tags
                    runSpacing: 4.0, // Vertical space between rows of tags
                    children: (novel.genres?.split(", ") ?? []).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration( 
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(), ),
                  const SizedBox(height: 100,),
                ],
              ),
            ),
            Container(alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 20),
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: (){},
                      child: SizedBox(
                        width: width * .3,
                        height: 50,
                        child: const Center(
                          child: Text("Start Reading", overflow: TextOverflow.ellipsis,),
                        ),
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        onTap();

                        // print("${widget.novel.toJson()}");

                        // if(!inLibrary) {
                        //   libraryController.addToLibrary(newNovel);
                        //   setState(() {
                        //     inLibrary = true;
                        //   });
                        // } else {
                        //   libraryController.removeFromLibrary(newNovel);
                        //   setState(() {
                        //     inLibrary = false;
                        //   });
                        // }

                      },
                      child: SizedBox(
                        width: width * .3,
                        height: 50,
                        child: Center(
                          child: inLibrary ? const Text("Remove from Library", overflow: TextOverflow.ellipsis)
                              : const Text("Add to Library", overflow: TextOverflow.ellipsis),
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}
