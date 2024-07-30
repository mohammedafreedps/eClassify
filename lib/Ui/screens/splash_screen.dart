// import 'dart:async';

import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eClassify/Ui/screens/Onboarding/onboarding_screen.dart';
import 'package:eClassify/Ui/screens/widgets/Errors/no_internet.dart';
import 'package:eClassify/Utils/AppIcon.dart';
import 'package:eClassify/Utils/Extensions/extensions.dart';
import 'package:eClassify/Utils/responsiveSize.dart';
import 'package:eClassify/Utils/ui_utils.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/Repositories/system_repository.dart';

// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../app/routes.dart';
import 'package:eClassify/data/cubits/system/fetch_language_cubit.dart';
import 'package:eClassify/data/cubits/system/fetch_system_settings_cubit.dart';
import 'package:eClassify/data/model/system_settings_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:eClassify/main.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/error/error_text.dart';
import '../../data/cubits/system/language_cubit.dart';

import '../../exports/main_export.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/tabbar/tabbar_screen.dart';
import '../../wwlcommerce/helper/utils/generalImports.dart';
import '../../wwlcommerce/provider/appSettingsProvider.dart';
import 'package:eClassify/wwlcommerce/provider/appLanguageProvider.dart' as wwllang;
import 'package:eClassify/wwlcommerce/helper/utils/constant.dart' as wwlconst;
import 'package:eClassify/Utils/constant.dart' as olxconst;
class SplashScreenOlx extends ConsumerStatefulWidget {
  const SplashScreenOlx({super.key});

  @override
  SplashScreenOlxState createState() => SplashScreenOlxState();
}

class SplashScreenOlxState extends ConsumerState<SplashScreenOlx>
    with TickerProviderStateMixin {
  //late OldAuthenticationState authenticationState;

  bool isTimerCompleted = false;
  bool isSettingsLoaded = false; //TODO: temp
  bool isLanguageLoaded = false;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasInternet = true;
  late PackageInfo packageInfo;
  String currentAppVersion = "1.0.0";

  @override
  void initState() {
    locationPermission();
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        hasInternet = (!result.contains(ConnectivityResult.none));
        //hasInternet = result != ConnectivityResult.none;
      });
      if (hasInternet) {
        getDefaultLanguage();

        checkIsUserAuthenticated();
        startTimer();
      }
    });
   /* Future.delayed(Duration.zero).then(
          (value) {
        callAllApis();
      },
    );*/
  }

  /*callAllApis() {
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
        if (wwlconst.Constant.session
            .getData(SessionManager.keySelectedLanguageId)
            .isEmpty) {
          params[ApiAndParams.is_default] = "1";
        } else {
          params[ApiAndParams.id] =
              wwlconst.Constant.session.getData(SessionManager.keySelectedLanguageId);
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
                wwllang.LanguageState.loaded &&
                context.read<AppSettingsProvider>().settingsState ==
                    SettingsState.loaded) {
              //startTime();
            }
          });
        });
      });
    } on SocketException {
      context.read<AppSettingsProvider>().changeState();
      throw wwlconst.Constant.noInternetConnection;
    } catch (e) {
      context.read<AppSettingsProvider>().changeState();
      throw wwlconst.Constant.somethingWentWrong;
    }
  }*/

  // bool isDataAvailable = checkPersistedDataAvailibility();
  /*Connectivity().checkConnectivity().then((value) {
      if (value.contains(ConnectivityResult.none)) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return NoInternet(
              onRetry: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.splash,
                );
              },
            );
          },
        ));
      } else {
        startTimer();
      }
    });

    //get Currency Symbol from Admin Panel
*/ /*    Future.delayed(Duration.zero, () {
      context.read<ProfileSettingCubit>().fetchProfileSetting(
            context,
            Api.currencySymbol,
          );
    });*/ /*
  }*/

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> locationPermission() async {
    if ((await Permission.location.status) == PermissionStatus.denied) {
      await Permission.location.request();
    }
  }

  Future getDefaultLanguage() async {
    try {
      Map result = await SystemRepository().fetchSystemSettings();

      var code = (result['data']['default_language']);

      if (HiveUtils.getLanguage() == null ||
          HiveUtils.getLanguage()?['data'] == null) {
        context.read<FetchLanguageCubit>().getLanguage(code);
      }
      else if (HiveUtils.isUserFirstTime() == true && code != HiveUtils.getLanguage()?['code']) {
        context.read<FetchLanguageCubit>().getLanguage(code);
      }
      else {
        isLanguageLoaded = true;
        setState(() {});
      }
    } catch (e) {
      print("Error while load default language $e");
    }
  }

  void checkIsUserAuthenticated() async {
    context.read<FetchSystemSettingsCubit>().fetchSettings(forceRefresh: true);
  }

  Future<void> startTimer() async {
    Timer(const Duration(seconds: 1), () {
      isTimerCompleted = true;
      if (mounted) setState(() {});
    });
  }

  void navigateCheck() {
    if (isTimerCompleted && isSettingsLoaded && isLanguageLoaded) {
      navigateToScreen();
    }
  }

  void navigateToScreen() {
    if (context
            .read<FetchSystemSettingsCubit>()
            .getSetting(SystemSetting.maintenanceMode) ==
        "1") {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(Routes.maintenanceMode);
        }
      });
    } else if (HiveUtils.isUserFirstTime() == true) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(Routes.onboarding);
        }
      });
    } else if (HiveUtils.isUserAuthenticated()) {
      if (HiveUtils.getUserDetails().name == "" ||
          HiveUtils.getUserDetails().email == "" ||
          HiveUtils.getUserDetails().mobile == "") {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.pushReplacementNamed(
              context,
              Routes.completeProfile,
              arguments: {
                "from": "login",
              },
            );
          },
        );
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          // Watch the authentication state
          final authState = ref.watch(authStateChangeProvider);
          authState.when(
            data: (user) {
              if (user != null) {
                // Fetch user data if authenticated
                getData(ref, user,context).then((_) {
                  // Navigate to TabbarScreen after fetching user data
                  if (mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const TabbarScreen(),
                      ),
                    );
                  }
                });
              } else {
                // Navigate to OnboardingScreen if not authenticated
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
                    ),
                  );
                }
              }
            },
            error: (error, st) {
              // Handle error state if needed
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ErrorScreen(error: error.toString()),
                  ),
                );
              }
            },
            loading: () {
              // Keep showing splash screen while loading
            },
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        }
      });
    }
  }
  Future<void> getData(WidgetRef ref, User user, BuildContext context) async {
    final userModel = await ref
        .read(authControllerProvider.notifier)
        .getCurrentUserDataaaa();
    ref.read(userProvider.notifier).update((state) => userModel);
  }
  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );*/

    navigateCheck();

    return hasInternet
        ? BlocListener<FetchLanguageCubit, FetchLanguageState>(
            listener: (context, state) {
              if (state is FetchLanguageSuccess) {
                Map<String, dynamic> map = state.toMap();

                var data = map['file_name'];
                map['data'] = data;
                map.remove("file_name");

                HiveUtils.storeLanguage(map);
                context.read<LanguageCubit>().emit(LanguageLoader(map));
                isLanguageLoaded = true;
                if (mounted) {
                  setState(() {});
                }
              }
            },
            child: BlocListener<FetchSystemSettingsCubit,
                FetchSystemSettingsState>(
              listener: (context, state) {
                if (state is FetchSystemSettingsSuccess) {
                  olxconst.Constant.isDemoModeOn = context
                      .read<FetchSystemSettingsCubit>()
                      .getSetting(SystemSetting.demoMode);

                  isSettingsLoaded = true;
                  setState(() {});
                }
                if (state is FetchSystemSettingsFailure) {}
              },
              child: AnnotatedRegion(
                value: SystemUiOverlayStyle(
                  statusBarColor: context.color.territoryColor,
                ),
                child: Scaffold(
                  backgroundColor: context.color.territoryColor,
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //child: UiUtils.getSvg(AppIcons.companyLogo),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0.rh(context)),
                          child: SizedBox(
                            width: 150.rw(context),
                            height: 150.rh(context),
                            child: Image.asset('assets/Icons/splash_logo.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0.rh(context)),
                        child: Column(
                          children: [
                            Text("World Work Links")
                                .size(context.font.xxLarge)
                                .color(context.color.secondaryColor)
                                .centerAlign()
                                .bold(weight: FontWeight.w600),
                            /*Text("\"${"buyAndSellAnything".translate(context)}\"")
                                .size(context.font.smaller)
                                .color(context.color.secondaryColor)
                                .centerAlign(),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : NoInternet(
            onRetry: () {
              setState(() {});
            },
          );
  }
}
