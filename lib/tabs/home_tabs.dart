import 'package:flutter/material.dart';
import 'package:novel_world/pages/home_page.dart';

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
            children: const [
              HomePage(),
              Text("Hola"),
              Text("Hola"),
              Text("Hola")
            ],
          ),
          bottomNavigationBar:  BottomNavigationBar(
            selectedLabelStyle:
            const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
            showUnselectedLabels: false,
            selectedIconTheme:
            const IconThemeData(size: 25, color: Colors.blue),
            backgroundColor: Colors.transparent,
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
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/book.png"),
                    color: Colors.black,
                  ),
                label: "My Library"
              ),
               BottomNavigationBarItem(
                  icon: pageIndex == 1 ? const ImageIcon(
                    AssetImage("assets/images/compass.png"),
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/compass-circular-tool.png"),
                    color: Colors.black,
                  ),
                  label: "Sources"
              ),
              BottomNavigationBarItem(
                  icon: pageIndex == 2 ? const ImageIcon(
                    AssetImage("assets/images/history.png"),
                    color: Colors.black,
                  ) : const ImageIcon(
                    AssetImage("assets/images/restore.png"),
                    size: 30,
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
