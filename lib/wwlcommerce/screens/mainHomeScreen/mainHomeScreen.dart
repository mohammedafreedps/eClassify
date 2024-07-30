import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'package:geolocator/geolocator.dart';
class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => HomeMainScreenState();
}

class HomeMainScreenState extends State<HomeMainScreen> {
  NetworkStatus networkStatus = NetworkStatus.online;
  late HomeMainScreenProvider _provider;
  late PackageInfo packageInfo;
  String currentAppVersion = "1.0.0";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = context.read<HomeMainScreenProvider>();
  }

  @override
  void dispose() {
    print("HomeMainScreenState: dispose called");
    _provider.scrollController[0].removeListener(() {});
    _provider.scrollController[1].removeListener(() {});
    _provider.scrollController[2].removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    print("HomeMainScreenState: initState called");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSessionDependentData();
    });

    if (mounted) {
      context.read<HomeMainScreenProvider>().setPages();
      Future.delayed(Duration.zero, () async {
        try {
          await LocalAwesomeNotification().init(context);
        } catch (e) {
          // Handle exception
        }
      });
    }
    super.initState();
  }

  void _initializeSessionDependentData() async {
    await Future.delayed(Duration.zero, () async {
      try {
        await LocalAwesomeNotification().init(context);

        final session = _provider.sessionManager;
        if (session.getData(SessionManager.keyFCMToken).isEmpty) {
          await FirebaseMessaging.instance.getToken().then((fcmToken) {
            session.setData(SessionManager.keyFCMToken, fcmToken!, false);
            if (!session.isUserLoggedIn()) {
              registerFcmKey(context: context, fcmToken: fcmToken);
            }
          });
        }
        callAllApis();
        FirebaseMessaging.onBackgroundMessage(LocalAwesomeNotification.onBackgroundMessageHandler);
      } catch (ignore) {}

      final session = _provider.sessionManager;
      if ((session.getData(SessionManager.keyLatitude) == "" &&
          session.getData(SessionManager.keyLongitude) == "") ||
          (session.getData(SessionManager.keyLatitude) == "0" &&
              session.getData(SessionManager.keyLongitude) == "0")) {
        Navigator.pushNamed(context, confirmLocationScreeneCom, arguments: [null, "location"]);
      } else {
        if (session.isUserLoggedIn()) {
          await getAppNotificationSettingsRepository(params: {}, context: context).then(
                (value) async {
              if (value[ApiAndParams.status].toString() == "1") {
                late AppNotificationSettings notificationSettings = AppNotificationSettings.fromJson(value);
                if (notificationSettings.data!.isEmpty) {
                  await updateAppNotificationSettingsRepository(params: {
                    ApiAndParams.statusIds: "1,2,3,4,5,6,7,8",
                    ApiAndParams.mobileStatuses: "1,1,1,1,1,1,1,1",
                    ApiAndParams.mailStatuses: "1,1,1,1,1,1,1,1"
                  }, context: context);
                }
              }
            },
          );
        }
      }
    });
  }
  callAllApis() {
    try {
      context
          .read<AppSettingsProvider>()
          .getAppSettingsProvider(context)
          .then((value) async {
        packageInfo = await PackageInfo.fromPlatform();
        currentAppVersion = packageInfo.version;
        LocationPermission permission;
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }

        Map<String, String> params = {ApiAndParams.system_type: "1"};
        if (Constant.session
            .getData(SessionManager.keySelectedLanguageId)
            .isEmpty) {
          params[ApiAndParams.is_default] = "1";
        } else {
          params[ApiAndParams.id] =
              Constant.session.getData(SessionManager.keySelectedLanguageId);
        }

        await context.read<LanguageProvider>().getAvailableLanguageList(
            params: {ApiAndParams.system_type: "1"},
            context: context).then((value) {
          context
              .read<LanguageProvider>()
              .getLanguageDataProvider(
            params: params,
            context: context,
          )
              .then((value) {
            if (context.read<LanguageProvider>().languageState ==
                LanguageState.loaded &&
                context.read<AppSettingsProvider>().settingsState ==
                    SettingsState.loaded) {
              //startTime();
            }
          });
        });
      });
    } on SocketException {
      context.read<AppSettingsProvider>().changeState();
      throw Constant.noInternetConnection;
    } catch (e) {
      context.read<AppSettingsProvider>().changeState();
      throw Constant.somethingWentWrong;
    }
  }
  @override
  Widget build(BuildContext context) {
    print("HomeMainScreenState: build called");
    return Consumer<HomeMainScreenProvider>(
      builder: (context, homeMainScreenProvider, child) {
        final session = homeMainScreenProvider.sessionManager;
        int currentPage = homeMainScreenProvider.getCurrentPage();
        return Scaffold(
          bottomNavigationBar: homeBottomNavigation(
            homeMainScreenProvider.getCurrentPage(),
            homeMainScreenProvider.selectBottomMenu,
            homeMainScreenProvider.getPages().length,
            context,
          ),
          body: networkStatus == NetworkStatus.online
              ? WillPopScope(
                  onWillPop: () {
                    if (currentPage == 0) {
                      return Future.value(true);
                    } else {
                      if (mounted) {
                        if (currentPage == 1) {
                          if (mounted) {
                            setState(
                              () {
                                currentPage = 0;
                              },
                            );
                          }
                        } else {
                          setState(
                            () {
                              currentPage = 0;
                            },
                          );
                        }
                      }
                      return Future.value(false);
                    }
                  },
                  child: IndexedStack(
                    index: currentPage,
                    children: homeMainScreenProvider.getPages(),
                  ),
                )
              : Center(
                  child: CustomTextLabel(
                    jsonKey: "check_internet",
                  ),
                ),
        );
      },
    );
  }

  homeBottomNavigation(int selectedIndex, Function selectBottomMenu,
      int totalPage, BuildContext context) {
    List lblHomeBottomMenu = [
      /*getTranslatedValue(
        context,
        "home_bottom_menu_home",
      ),*/
      getTranslatedValue(
        context,
        "home_bottom_menu_category",
      ),
      getTranslatedValue(
        context,
        "home_bottom_menu_wishlist",
      ),
      getTranslatedValue(
        context,
        "home_bottom_menu_profile",
      ),
    ];
    return BottomNavigationBar(
        items: List.generate(
          totalPage,
              (index) => BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: Widgets.getHomeBottomNavigationBarIcons(
                isActive: selectedIndex == index)[index],
            label: lblHomeBottomMenu[index],
          ),
        ),
        type: BottomNavigationBarType.shifting,
        currentIndex: 0, // Set the index of "Category" as default
        selectedItemColor: ColorsRes.mainTextColor,
        unselectedItemColor: Colors.transparent,
        onTap: (int ind) {
          selectBottomMenu(ind);
        },
        elevation: 5);
  }

}
