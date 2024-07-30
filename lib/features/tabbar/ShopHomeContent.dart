import '../../wwlcommerce/helper/utils/generalImports.dart';
import '../home/home_screen.dart';


/*
class ShopHomeContent extends HomeContent {
  final String title;
  final String imagePath;
  final Widget screen;

  ShopHomeContent({
    required this.title,
    required this.imagePath,
    required this.screen,
  }) : super(title: title, imagePath: imagePath, screen: screen);

  Future<SharedPreferences> _initPrefs() async {
    return await SharedPreferences.getInstance();
  }



  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: _initPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error initializing preferences'));
        } else {
          final prefs = snapshot.data!;

          return ChangeNotifierProvider<SessionManager>(
            create: (_) => SessionManager(prefs: prefs),
            child: Consumer<SessionManager>(
              builder: (context, sessionNotifier, child) {
                // Ensuring that Constant.session is set after the sessionNotifier is created
              //  WidgetsBinding.instance.addPostFrameCallback((_) {
                  Constant.session = sessionNotifier;
                  print("Session Set");
                  Constant.searchedItemsHistoryList = Constant.session.prefs
                      .getStringList(SessionManager.keySearchHistory) ??
                      [];

                  if (Constant.session
                      .getData(SessionManager.appThemeName)
                      .toString()
                      .isEmpty) {
                    Constant.session.setData(
                        SessionManager.appThemeName, Constant.themeList[0], false);
                    Constant.session.setBoolData(
                        SessionManager.isDarkTheme,
                        PlatformDispatcher.instance.platformBrightness ==
                            Brightness.dark,
                        false);
                  }

                  PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
                    if (Constant.session.getData(SessionManager.appThemeName) ==
                        Constant.themeList[0]) {
                      Constant.session.setBoolData(
                          SessionManager.isDarkTheme,
                          PlatformDispatcher.instance.platformBrightness ==
                              Brightness.dark,
                          true);
                    }
                  };
             //   });

                return Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    // Ensure that Constant.session is set before accessing its properties
                    if (Constant.session == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: MaterialApp(
                        builder: (context, child) {
                          return ScrollConfiguration(
                            behavior: GlobalScrollBehavior(),
                            child: Directionality(
                              textDirection:
                              languageProvider.languageDirection.toLowerCase() ==
                                  "rtl"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: child!,
                            ),
                          );
                        },
                        navigatorKey: Constant.navigatorKay,
                        onGenerateRoute: RouteGenerator.generateRoute,
                        initialRoute: "/",
                        scrollBehavior: ScrollGlowBehavior(),
                        debugShowCheckedModeBanner: false,
                        title: "egrocer",
                        theme: ColorsRes.setAppTheme().copyWith(
                          textTheme:
                          GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
                        ),
                        home: screen,
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}


*/
