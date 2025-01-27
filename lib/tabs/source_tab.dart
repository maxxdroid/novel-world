import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_world/consts/source_consts.dart';
import 'package:novel_world/model/source_model.dart';
import 'package:novel_world/sources/novelhi/views/novelhi_home.dart';
import 'package:novel_world/sources/novelbin/views/novel_bin_home.dart';

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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sources.length,
            itemBuilder: (context, index) {
              return sourceWidget(width, sources[index]);
            }
        ),
      ),
    );
  }

  sourceWidget (double width, SourceModel source) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: source.onTap,
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
                          source.icon,
                          height: 40,
                          width: 40, // Match height and width to ensure a circular shape
                          fit: BoxFit.cover, // Ensures the image fits well within the circle
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(source.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                        const Text("English")
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
