import 'dart:ui';

import 'package:eClassify/Utils/Network/apiCallTrigger.dart';
import 'package:eClassify/app/register_cubits.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/wwlcommerce/helper/sessionManager.dart';
import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'package:eClassify/wwlcommerce/provider/appLanguageProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'Ui/screens/Auth/login_screen.dart';
import 'core/error/error_text.dart';
import 'data/model/user_model.dart';
import 'exports/main_export.dart';
import 'package:eClassify/data/cubits/system/language_cubit.dart' as eclasslang;
import 'package:eClassify/wwlcommerce/helper/utils/constant.dart' as wwlconstant;
import 'package:eClassify/Utils/constant.dart' as eclassconstant;
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/models/user_modelaaa.dart';
import 'features/tabbar/tabbar_screen.dart';
/////////////
///V-1.0.0//
////////////

/*void main() => initApp();*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  initApp(prefs);
}

class EntryPoint extends StatefulWidget {
  final SharedPreferences prefs;
  const EntryPoint({
    super.key,
    required this.prefs,
  });

  @override
  EntryPointState createState() => EntryPointState();
}

class EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(
        NotificationService.onBackgroundMessageHandler);
    ChatGlobals.init();

  }

  @override
  Widget build(BuildContext context) {
    return riverpod.ProviderScope(
        child: MultiBlocProvider(
        providers: [
          provider.ChangeNotifierProvider<SessionManager>(
            create: (_) => SessionManager(prefs: widget.prefs),
          ),
          provider.ChangeNotifierProvider<LanguageProvider>(
            create: (context) {
              final languageProvider = LanguageProvider();
              languageProvider.getAvailableLanguageList(
                params: {}, // Pass necessary params
                context: context,
              );
              languageProvider.getLanguageDataProvider(
                params: {}, // Pass necessary params
                context: context,
              );
              return languageProvider;
            },
          ),
          provider.ChangeNotifierProvider<HomeMainScreenProvider>(
            create: (context) {
              final sessionManager = provider.Provider.of<SessionManager>(context, listen: false);
              return HomeMainScreenProvider(sessionManager: sessionManager);
            },
          ),
          provider.ChangeNotifierProvider<CategoryListProvider>(
            create: (context) {
              return CategoryListProvider();
            },
          ),
          provider.ChangeNotifierProvider<CityByLatLongProvider>(
            create: (context) {
              return CityByLatLongProvider();
            },
          ),
          provider.ChangeNotifierProvider<HomeScreenProvider>(
            create: (context) {
              return HomeScreenProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductChangeListingTypeProvider>(
            create: (context) {
              return ProductChangeListingTypeProvider();
            },
          ),
          provider.ChangeNotifierProvider<FaqProvider>(
            create: (context) {
              return FaqProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductWishListProvider>(
            create: (context) {
              return ProductWishListProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductAddOrRemoveFavoriteProvider>(
            create: (context) {
              return ProductAddOrRemoveFavoriteProvider();
            },
          ),
          provider.ChangeNotifierProvider<UserProfileProvider>(
            create: (context) {
              return UserProfileProvider();
            },
          ),
          provider.ChangeNotifierProvider<CartListProvider>(
            create: (context) {
              return CartListProvider();
            },
          ),
          provider.ChangeNotifierProvider<LanguageProvider>(
            create: (context) {
              return LanguageProvider();
            },
          ),
          provider.ChangeNotifierProvider<AppSettingsProvider>(
            create: (context) {
              return AppSettingsProvider();
            },
          ),
          ...RegisterCubits().providers,
        ],
        child: const App(),
        ),);
  }
}

class App extends riverpod.ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
 // State<App> createState() => _AppState();
}


class _AppState extends riverpod.ConsumerState<App> {
  UserModelS? userModel;
  void getData(riverpod.WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getCurrentUserDataaaa();
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }
  @override
  void initState() {




    context.read<LanguageCubit>().loadCurrentLanguage();

    AppTheme currentTheme = HiveUtils.getCurrentTheme();

    ///Initialized notification services
    LocalAwsomeNotification().init(context);
    ///////////////////////////////////////
    NotificationService.init(context);

    /// Initialized dynamic links for share items feature
    //DeepLinkManager.initDeepLinks();
    context.read<AppThemeCubit>().changeTheme(currentTheme);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;

    return BlocListener<GetApiKeysCubit, GetApiKeysState>(
      listener: (context, state) {
        if (state is GetApiKeysSuccess) {
          AppSettings.stripeCurrency = state.stripeCurrency;
          AppSettings.stripePublishableKey = state.stripePublishableKey;
        }
      },
      child: BlocBuilder<LanguageCubit, eclasslang.LanguageState>(
        builder: (context, languageState) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: GetMaterialApp(
              home: riverpod.Consumer(
                builder: (context, ref, _) {
                  return ref.watch(authStateChangeProvider).when(
                    data: (user) {
                      if (user != null) {
                        getData(ref, user);
                        return const TabbarScreen();
                      } else {
                        return const LoginScreen();
                      }
                    },
                    error: (error, st) {
                      return ErrorScreen(
                        error: error.toString(),
                      );
                    },
                    loading: () => const LoadingScreen(),
                  );
                },
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.onGenerateRouted,
              theme: appThemeData[currentTheme],
              builder: (context, child) {
                TextDirection? direction;

                if (languageState is LanguageLoader) {
                  direction = languageState.language['rtl'] == true ? TextDirection.rtl : TextDirection.ltr;
                } else {
                  direction = TextDirection.ltr;
                }

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: Directionality(
                    textDirection: direction,
                    child: DevicePreview(
                      enabled: false,
                      builder: (context) {
                        return child!;
                      },
                    ),
                  ),
                );
              },
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: loadLocalLanguageIfFail(languageState),
            ),
          );
        },
      ),
    );
  }



  /*@override
  Widget build(BuildContext context) {
    // Continuously watching theme change
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;
    return BlocListener<GetApiKeysCubit, GetApiKeysState>(
                listener: (context, state) {
                  if (state is GetApiKeysSuccess) {
                    AppSettings.stripeCurrency = state.stripeCurrency;
                    AppSettings.stripePublishableKey = state.stripePublishableKey;
                    //AppSettings.stripeSecretKey = state.stripeSecretKey;
                  }
                },
                child: BlocBuilder<LanguageCubit, eclasslang.LanguageState>(
                  builder: (context, languageState) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: ProviderScope(
                        child: GetMaterialApp(
                          home: ref.watch(authStateChangeProvider).when(
                            data: (user) {
                              if (user != null) {
                                getData(ref, user);
                                return const TabbarScreen();
                              } else {

                                return const LoginScreen();
                              }
                            },
                            error: (error, st) {
                              return ErrorScreen(
                                error: error.toString(),
                              );
                            },
                            loading: () => const LoadingScreen(),
                          ),
                        //  home: const TabbarScreen(),
                         // initialRoute: Routes.splash,
                         // navigatorKey: Constant.navigatorKey,
                         // title: Constant.appName,
                          debugShowCheckedModeBanner: false,
                          onGenerateRoute: Routes.onGenerateRouted,
                          theme: appThemeData[currentTheme],
                          builder: (context, child) {
                            TextDirection? direction;

                            if (languageState is LanguageLoader) {
                              if (languageState.language['rtl'] == true) {
                                direction = TextDirection.rtl;
                              } else {
                                direction = TextDirection.ltr;
                              }
                            } else {
                              direction = TextDirection.ltr;
                            }

                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaler: const TextScaler.linear(
                                    1.0), // set text scale factor to 1 so that this will not resize app's text while user changes their system settings text scale
                              ),
                              child: Directionality(
                                textDirection: direction,
                                child: DevicePreview(
                                  enabled: false,
                                  builder: (context) {
                                    return child!;
                                  },
                                ),
                              ),
                            );
                          },
                          localizationsDelegates: const [
                            AppLocalization.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          locale: loadLocalLanguageIfFail(languageState),
                        ),
                      ),
                    );
                  },
                ),
              );
           // },
      //    );
     //   },
    //  ),
  //  );
  }*/

  dynamic loadLocalLanguageIfFail(eclasslang.LanguageState state) {
    if ((state is LanguageLoader)) {
      return Locale(state.language['code']);
    } else if (state is LanguageLoadFail) {
      return const Locale("en");
    }
  }

/*  void getData(WidgetRef ref, User user) {

  }*/
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


/*
late final SharedPreferences prefs;
void main() => initApp();

class EntryPoint extends StatefulWidget {
  const EntryPoint({
    super.key,
  });

  @override
  EntryPointState createState() => EntryPointState();
}

class EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(
        NotificationService.onBackgroundMessageHandler);
    ChatGlobals.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          provider.ChangeNotifierProvider<HomeMainScreenProvider>(
            create: (context) {
              return HomeMainScreenProvider();
            },
          ),
          provider.ChangeNotifierProvider<CategoryListProvider>(
            create: (context) {
              return CategoryListProvider();
            },
          ),
          provider.ChangeNotifierProvider<CityByLatLongProvider>(
            create: (context) {
              return CityByLatLongProvider();
            },
          ),
          provider.ChangeNotifierProvider<HomeScreenProvider>(
            create: (context) {
              return HomeScreenProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductChangeListingTypeProvider>(
            create: (context) {
              return ProductChangeListingTypeProvider();
            },
          ),
          provider.ChangeNotifierProvider<FaqProvider>(
            create: (context) {
              return FaqProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductWishListProvider>(
            create: (context) {
              return ProductWishListProvider();
            },
          ),
          provider.ChangeNotifierProvider<ProductAddOrRemoveFavoriteProvider>(
            create: (context) {
              return ProductAddOrRemoveFavoriteProvider();
            },
          ),
          provider.ChangeNotifierProvider<UserProfileProvider>(
            create: (context) {
              return UserProfileProvider();
            },
          ),
          provider.ChangeNotifierProvider<CartListProvider>(
            create: (context) {
              return CartListProvider();
            },
          ),
          provider.ChangeNotifierProvider<LanguageProvider>(
            create: (context) {
              return LanguageProvider();
            },
          ),
          provider.ChangeNotifierProvider<AppSettingsProvider>(
            create: (context) {
              return AppSettingsProvider();
            },
          ),
          ...RegisterCubits().providers,
        ],
        child: Builder(builder: (BuildContext context) {
          return const App();
        }));
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    context.read<LanguageCubit>().loadCurrentLanguage();
  //  initialzeshared();
    AppTheme currentTheme = HiveUtils.getCurrentTheme();

    ///Initialized notification services
    LocalAwsomeNotification().init(context);
    ///////////////////////////////////////
    NotificationService.init(context);

    /// Initialized dynamic links for share items feature
    //DeepLinkManager.initDeepLinks();
    context.read<AppThemeCubit>().changeTheme(currentTheme);

    super.initState();
  }
  Future<SharedPreferences> _initPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    //Continuously watching theme change
    AppTheme currentTheme = context.watch<AppThemeCubit>().state.appTheme;
    return FutureBuilder<SharedPreferences>(
        future: _initPrefs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error initializing preferences'));
          } else {
            final prefs = snapshot.data!;
            return provider.ChangeNotifierProvider<SessionManager>(
              create: (_) => SessionManager(prefs: prefs),
              child: provider.Consumer<SessionManager>(
                builder: (context, SessionManager sessionNotifier, child) {
                  wwlconstant.Constant.session =
                      provider.Provider.of<SessionManager>(context);

                  wwlconstant.Constant.searchedItemsHistoryList =
                      wwlconstant.Constant.session.prefs
                          .getStringList(SessionManager.keySearchHistory) ??
                          [];

                  if (wwlconstant.Constant.session
                      .getData(SessionManager.appThemeName)
                      .toString()
                      .isEmpty) {
                    wwlconstant.Constant.session.setData(
                        SessionManager.appThemeName,
                        wwlconstant.Constant.themeList[0], false);
                    wwlconstant.Constant.session.setBoolData(
                        SessionManager.isDarkTheme,
                        PlatformDispatcher.instance.platformBrightness ==
                            Brightness.dark,
                        false);
                  }

                  // This callback is called every time the brightness changes from the device.
                  PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
                    if (wwlconstant.Constant.session.getData(
                        SessionManager.appThemeName) ==
                        wwlconstant.Constant.themeList[0]) {
                      wwlconstant.Constant.session.setBoolData(
                          SessionManager.isDarkTheme,
                          PlatformDispatcher.instance.platformBrightness ==
                              Brightness.dark,
                          true);
                    }
                  };
                },

                child: BlocListener<GetApiKeysCubit, GetApiKeysState>(
                  listener: (context, state) {
                    if (state is GetApiKeysSuccess) {
                      AppSettings.stripeCurrency = state.stripeCurrency;
                      AppSettings.stripePublishableKey = state.stripePublishableKey;
                      //AppSettings.stripeSecretKey = state.stripeSecretKey;
                    }
                  },
                  child: BlocBuilder<LanguageCubit, eclasslang.LanguageState>(
                    builder: (context, languageState) {
                      return ProviderScope(
                        child: MaterialApp(
                          initialRoute: Routes.splash,
                          // App will start from here splash screen is first screen,
                          navigatorKey: eclassconstant.Constant.navigatorKey,
                          //This navigator key is used for Navigate users through notification
                          title: eclassconstant.Constant.appName,
                          debugShowCheckedModeBanner: false,
                          onGenerateRoute: Routes.onGenerateRouted,
                          theme: appThemeData[currentTheme],
                          builder: (context, child) {
                            TextDirection? direction;

                            if (languageState is LanguageLoader) {
                              if (languageState.language['rtl'] == true) {
                                direction = TextDirection.rtl;
                              } else {
                                direction = TextDirection.ltr;
                              }
                            } else {
                              direction = TextDirection.ltr;
                            }
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaler: const TextScaler.linear(
                                    1.0), //set text scale factor to 1 so that this will not resize app's text while user change their system settings text scale
                              ),
                              child: Directionality(
                                textDirection: direction,
                                //This will convert app direction according to language
                                child: DevicePreview(
                                  enabled: false,

                                  /// Turn on this if you want to test the app in different screen sizes
                                  builder: (context) {
                                    return child!;
                                  },
                                ),
                              ),
                            );
                          },
                          localizationsDelegates: const [
                            AppLocalization.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          locale: loadLocalLanguageIfFail(languageState),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }

        }
    );
  }

  dynamic loadLocalLanguageIfFail(eclasslang.LanguageState state) {
    if ((state is LanguageLoader)) {
      return Locale(state.language['code']);
    } else if (state is LanguageLoadFail) {
      return const Locale("en");
    }
  }

  Future<void> initialzeshared() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
*/
