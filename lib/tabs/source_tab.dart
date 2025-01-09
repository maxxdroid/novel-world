import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_world/novelhi/novelhi_home.dart';
import 'package:novel_world/pages/source_home.dart';

class SourceTabs extends StatefulWidget {
  const SourceTabs({super.key});

  @override
  State<SourceTabs> createState() => _SourceTabsState();
}

class _SourceTabsState extends State<SourceTabs> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sources", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pinned"),
            sourceWidget(width),
            sourceWidget(width),
            const Text("All"),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
          ],
        ),
      ),
    );
  }

  sourceWidget (double width) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Get.to(() => const NovelHiHome());
      },
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: ClipOval(
                        child: Image.asset(
                          color: Colors.blue,
                          "assets/images/novelbin-logo.png",
                          height: 40,
                          width: 40, // Match height and width to ensure a circular shape
                          fit: BoxFit.cover, // Ensures the image fits well within the circle
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NovelBin", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("English")
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {}, icon: const ImageIcon(
                    AssetImage("assets/images/pin.png"),
                    // size: 20,
                    color: Colors.black,
                  )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
