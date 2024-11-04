import 'package:flutter/material.dart';

class SourceTabs extends StatefulWidget {
  const SourceTabs({super.key});

  @override
  State<SourceTabs> createState() => _SourceTabsState();
}

class _SourceTabsState extends State<SourceTabs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sources", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width),
            sourceWidget(width)
          ],
        ),
      ),
    );
  }

  sourceWidget (double width) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
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
