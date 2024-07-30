import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class HomeMainScreenProvider extends ChangeNotifier {
  final SessionManager sessionManager;

  HomeMainScreenProvider({required this.sessionManager}) {
    setPages();
  }

  int currentPage = 0;

  List<ScrollController> scrollController = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  List<Widget> pages = [];

  setPages() {
    pages = [
      ChangeNotifierProvider<ProductListProvider>(
        create: (context) {
          return ProductListProvider();
        },
        child: CategoryListScreen(
          scrollController: scrollController[0],
        ),
      ),
      WishListScreen(
        scrollController: scrollController[1],
      ),
      ProfileScreen(
        scrollController: scrollController[2],
      ),
    ];
  }

  Future selectBottomMenu(int index) async {
    try {
      if (index == currentPage) {
        scrollController[currentPage].animateTo(0,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      }
      currentPage = index;
    } catch (_) {}
    notifyListeners();
  }

  int getCurrentPage() {
    return currentPage;
  }

  List<Widget> getPages() {
    return pages;
  }
}



/*
class HomeMainScreenProvider extends ChangeNotifier {
  int currentPage = 0;


  List<ScrollController> scrollController = [
   // ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];

  //total pageListing
  List<Widget> pages = [];

  setPages() {
    pages = [
      ChangeNotifierProvider<ProductListProvider>(
        create: (context) {
          return ProductListProvider();
        },
        child: CategoryListScreen(
          scrollController: scrollController[0],
        ),
        */
/*HomeScreen(
          scrollController: scrollController[0],
        ),*//*

      ),
      */
/*CategoryListScreen(
        scrollController: scrollController[1],
      ),*//*

      WishListScreen(
        scrollController: scrollController[1],
      ),
      ProfileScreen(
        scrollController: scrollController[2],
      )
    ];
  }

  //change current screen based on bottom menu selection
  Future selectBottomMenu(int index) async {
    try {
      if (index == currentPage) {
        scrollController[currentPage].animateTo(0,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      }

      currentPage = index;
    } catch (_) {}
    notifyListeners();
  }

  getCurrentPage() {
    return currentPage;
  }

  getPages() {
    return pages;
  }
}
*/
