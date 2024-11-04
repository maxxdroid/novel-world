import 'package:flutter/material.dart';
import 'package:novel_world/model/novel.dart';

import '../novelbin/novelbin_service.dart';

class NovelDetails extends StatefulWidget {
  final Novel novel;
  const NovelDetails({super.key, required this.novel});

  @override
  State<NovelDetails> createState() => _NovelDetailsState();
}

class _NovelDetailsState extends State<NovelDetails> {
  late Future<Novel?> novel;
  
  @override
  void initState() {
    // TODO: implement initState
    novel = NovelBinService().getChapters(widget.novel);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.novel.title ?? ""),
        centerTitle: true,
      ),
      body: FutureBuilder<Novel?>(
          initialData: widget.novel,
          future: novel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final novel = (snapshot).data;
              return Stack(
                children: [
                  Image.network(novel!.imgUrl ?? "", height: 200, width: width, fit: BoxFit.cover,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.network(novel.imgUrl ?? "", height: 200, width: 150, fit: BoxFit.cover,),
                          const SizedBox(width: 10,),
                          Column(
                            children: [
                              SizedBox(width: 200, height: 300, child: Text(novel.description ?? "", overflow: TextOverflow.fade,))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                            itemCount: novel.chapters?.length,
                            itemBuilder: (context, index) {
                              return Text(novel.chapters?[index].title ?? "");
                            }),
                      )
                    ],
                  )
                ],
              );
            } else if(!snapshot.hasData) {
              return const Center(child: Text("No Data Found"),);
            }  else {
              return const Center(child: Text("No Data Found"),);
            }
          }
      ),
    );
  }
}
