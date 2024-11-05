import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novel_world/pages/source_home.dart';
import 'package:novel_world/tabs/library_tab.dart';
import 'package:novel_world/tabs/source_tab.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.white,
    ));

    super.initState();
    pageController = PageController(initialPage: pageIndex);
    pageController.addListener(() {
      setState(() {
        pageIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children:  const [
              MyLibrary(),
              SourceTabs(),
              Text("Hola"),
              Text("Hola")
            ],
          ),
          bottomNavigationBar:  BottomNavigationBar(
            selectedLabelStyle:
            const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedIconTheme:
            const IconThemeData(size: 25, color: Colors.blue),
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            onTap: ((index) {
              setState(() {
                pageIndex = index;
              });
              pageController.jumpToPage(index);
            }),
            items: [
              BottomNavigationBarItem(
                  icon: pageIndex == 0 ? const ImageIcon(
                    AssetImage("assets/images/open-book.png"),
                    size: 30,
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/book.png"),
                    size: 20,
                    color: Colors.black,
                  ),
                label: "My Library"
              ),
               BottomNavigationBarItem(
                  icon: pageIndex == 1 ? const ImageIcon(
                    AssetImage("assets/images/compass.png"),
                    size: 30,
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/compass-circular-tool.png"),
                    size: 20,
                    color: Colors.black,
                  ),
                  label: "Sources"
              ),
              BottomNavigationBarItem(
                  icon: pageIndex == 2 ? const ImageIcon(
                    AssetImage("assets/images/history.png"),
                    size: 30,
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/restore.png"),
                    size: 25,
                    color: Colors.black,
                  ),
                  label: "History"
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        )
    );
  }
}
