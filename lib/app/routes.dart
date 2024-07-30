import 'dart:developer';

import 'package:eClassify/Ui/screens/Auth/forgot_password.dart';
import 'package:eClassify/Ui/screens/Auth/signup_screen.dart';
import 'package:eClassify/Ui/screens/Chat/blocked_user_list_screen.dart';

import 'package:eClassify/Ui/screens/FavoriteScreen.dart';
import 'package:eClassify/Ui/screens/Home/Widgets/categoryFilterScreen.dart';
import 'package:eClassify/Ui/screens/Home/Widgets/postedSinceFilter.dart';
import 'package:eClassify/Ui/screens/Item/add_item_screen/Widgets/PdfViewer.dart';
import 'package:eClassify/Ui/screens/Item/add_item_screen/add_item_details.dart';
import 'package:eClassify/Ui/screens/Item/add_item_screen/confirm_location_screen.dart';
import 'package:eClassify/Ui/screens/Item/add_item_screen/more_details.dart';
import 'package:eClassify/Ui/screens/Item/items_list.dart';
import 'package:eClassify/Ui/screens/Map/choose_location_map.dart';
import 'package:eClassify/Ui/screens/SubCategory/SubCategoryScreen.dart';
import 'package:eClassify/Ui/screens/ad_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Ui/screens/Advertisement/my_advertisment_screen.dart';
import '../Ui/screens/Articles/article_details.dart';
import '../Ui/screens/Articles/articles_screen.dart';
import '../Ui/screens/Auth/login_screen.dart';
import '../Ui/screens/Home/Widgets/subCategoryFilterScreen.dart';
import '../Ui/screens/Home/category_list.dart';
import '../Ui/screens/Home/change_language_screen.dart';
import '../Ui/screens/Home/search_screen.dart';
import '../Ui/screens/Item/add_item_screen/Widgets/success_item_screen.dart';
import '../Ui/screens/Item/add_item_screen/select_category.dart';
import '../Ui/screens/Item/my_items_screen.dart';
import '../Ui/screens/Item/viewAll.dart';
import '../Ui/screens/Onboarding/onboarding_screen.dart';

import '../Ui/screens/Settings/contact_us.dart';
import '../Ui/screens/Settings/notification_detail.dart';
import '../Ui/screens/Settings/notifications.dart';
import '../Ui/screens/Settings/profile_setting.dart';
import '../Ui/screens/Subscription/packages_list.dart';

import '../Ui/screens/Subscription/transaction_history_screen.dart';
import '../Ui/screens/Userprofile/edit_profile.dart';
import '../Ui/screens/filter_screen.dart';
import '../Ui/screens/main_activity.dart';
import '../Ui/screens/splash_screen.dart';
import '../Ui/screens/widgets/AnimatedRoutes/blur_page_route.dart';
import '../Ui/screens/widgets/maintenance_mode.dart';
import '../Utils/DeepLink/nativeDeepLinkManager.dart';
import '../data/Repositories/Item/item_repository.dart';
import '../data/model/data_output.dart';
import '../data/model/item/item_model.dart';
import '../wwlcommerce/helper/utils/generalImports.dart';
import '../wwlcommerce/provider/SellerProvider.dart';
import '../wwlcommerce/provider/brandProvider.dart';
import '../wwlcommerce/provider/walletHistoryListProvider.dart';
import '../wwlcommerce/screens/appUpdateScreen.dart';
import '../wwlcommerce/screens/authenticationScreen/loginAccount.dart';
import '../wwlcommerce/screens/authenticationScreen/otpVerificationScreen.dart';
import '../wwlcommerce/screens/brandListScreen.dart';
import '../wwlcommerce/screens/introSliderScreen.dart';
import '../wwlcommerce/screens/mainHomeScreen/profileMenuScreen/screens/walletHistoryListScreen.dart';
import '../wwlcommerce/screens/sellerListScreen.dart';
import '../wwlcommerce/screens/splashScreen.dart';
import '../wwlcommerce/screens/underMaintenanceScreen.dart';

class Routes {
  //private constructor
  //Routes._();

  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const login = 'login';
  static const forgotPassword = 'forgotPassword';
  static const signup = 'signup';
  static const completeProfile = 'complete_profile';
  static const main = 'main';
  static const home = 'Home';
  static const addItem = 'addItem';
  static const waitingScreen = 'waitingScreen';
  static const categories = 'Categories';
  static const addresses = 'address';
  static const chooseAdrs = 'chooseAddress';
  static const itemsList = 'itemsList';
  static const contactUs = 'ContactUs';
  static const profileSettings = 'profileSettings';
  static const filterScreen = 'filterScreen';
  static const notificationPage = 'notificationpage';
  static const notificationDetailPage = 'notificationdetailpage';
  static const addItemScreenRoute = 'addItemScreenRoute';
  static const articlesScreenRoute = 'articlesScreenRoute';
  static const subscriptionPackageListRoute = 'subscriptionPackageListRoute';
  static const subscriptionScreen = 'subscriptionScreen';
  static const maintenanceMode = '/maintenanceMode';
  static const favoritesScreen = '/favoritescreen';
  static const promotedItemsScreen = '/promotedItemsScreen';
  static const mostLikedItemsScreen = '/mostLikedItemsScreen';
  static const mostViewedItemsScreen = '/mostViewedItemsScreen';
  static const articleDetailsScreenRoute = '/articleDetailsScreenRoute';

  static const languageListScreenRoute = '/languageListScreenRoute';
  static const searchScreenRoute = '/searchScreenRoute';
  static const chooseLocaitonMap = '/chooseLocationMap';
  static const itemMapScreen = '/ItemMap';
  static const dashboard = '/dashboard';
  static const subCategoryScreen = '/subCategoryScreen';
  static const categoryFilterScreen = '/categoryFilterScreen';
  static const subCategoryFilterScreen = '/subCategoryFilterScreen';
  static const postedSinceFilterScreen = '/postedSinceFilterScreen';

  static const myAdvertisment = '/myAdvertisment';
  static const transactionHistory = '/transactionHistory';
  static const personalizedItemScreen = '/personalizedItemScreen';
  static const myItemScreen = '/myItemScreen';
  static const pdfViewerScreen = '/pdfViewerScreen';

  ///Add Item screens
  static const selectItemTypeScreen = '/selectItemType';
  static const addItemDetailsScreen = '/addItemDetailsScreen';
  static const setItemParametersScreen = '/setItemParametersScreen';
  static const selectOutdoorFacility = '/selectOutdoorFacility';
  static const adDetailsScreen = '/adDetailsScreen';
  static const successItemScreen = '/successItemScreen';

  ///Add item screens
  static const selectCategoryScreen = '/selectCategoryScreen';
  static const selectNestedCategoryScreen = '/selectNestedCategoryScreen';
  static const addItemDetails = '/addItemDetails';
  static const addMoreDetailsScreen = '/addMoreDetailsScreen';
  static const confirmLocationScreen = '/confirmLocationScreen';
  static const sectionWiseItemsScreen = '/sectionWiseItemsScreen';
  static const blockedUserListScreen = '/blockedUserListScreen';


//E-Commerce Routes
  static const String introSliderScreen = 'introSliderScreen';
  static const String splashScreen = 'splashScreen';
  static const String loginScreen = 'loginScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String otpScreen = 'otpScreen';
  static const String editProfileScreen = 'editProfileScreen';
 // static const String confirmLocationScreen = 'confirmLocationScreen';
  static const String mainHomeScreen = 'mainHomeScreen';
  static const String brandListScreen = 'brandListScreen';
  static const String sellerListScreen = 'sellerListScreen';
  static const String subCategoryListScreen = 'subCategoryListScreen';
  static const String cartScreen = 'cartScreen';
  static const String checkoutScreen = 'checkoutScreen';
  static const String promoCodeScreen = 'promoCodeScreen';
  static const String productListScreen = 'productListScreen';
  static const String productSearchScreen = 'productSearchScreen';
  static const String productListFilterScreen = 'productListFilterScreen';
  static const String productDetailScreen = 'productDetailScreen';
  static const String fullScreenProductImageScreen = 'fullScreenProductImageScreen';
  static const String addressListScreen = 'addressListScreen';
  static const String addressDetailScreen = 'addressDetailScreen';
  static const String orderDetailScreen = 'orderDetailScreen';
  static const String orderHistoryScreen = 'orderHistoryScreen';
  static const String notificationListScreen = 'notificationListScreen';
  static const String transactionListScreen = 'transactionListScreen';
  static const String walletHistoryListScreen = 'walletHistoryListScreen';
  static  const String faqListScreen = 'faqListScreen';
  static const String orderPlaceScreen = 'orderPlaceScreen';
  static const String notificationsAndMailSettingsScreenScreen =
      'notificationsAndMailSettingsScreenScreen';
  static const String underMaintenanceScreen = 'underMaintenanceScreen';
  static const String appUpdateScreen = 'appUpdateScreen';
  static const String paypalPaymentScreen = 'paypalPaymentScreen';
  static const String confirmLocationScreeneCom = 'confirmLocationScreeneCom';
  //End E-Commerce







  // static const myItemsScreen = '/myItemsScreen';

  //Sandbox[test]
  static const playground = 'playground';

  static String currentRoute = splash;

  //static String previousCustomerRoute = splash;

  static Route onGenerateRouted(RouteSettings routeSettings) {
    //previousCustomerRoute = currentRoute;
    currentRoute = routeSettings.name ?? "";
 /*   print("Current Route is:::::::::"
        " ${routeSettings.name} ");*/

    if (routeSettings.name!.contains('/items-details/')) {
      int itemId = int.parse(routeSettings.name!.split('/').last);
      // Fetch item details based on the itemId
      return MaterialPageRoute(builder: (context) {
        return FutureBuilder<DataOutput<ItemModel>>(
          future: ItemRepository().fetchItemFromItemId(itemId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Return a loading indicator while fetching data
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              // Handle error case
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              // Navigate to adDetailsScreen with the fetched item details
              return AdDetailsScreen(model: snapshot.data!.modelList.first);
            }
          },
        );
      });
    }

    switch (routeSettings.name) {
      case splash:
        return BlurredRouter(builder: ((context) => const SplashScreenOlx()));
      case onboarding:
        return CupertinoPageRoute(
            builder: ((context) => const OnboardingScreen()));
      case main:
        return MainActivity.route(routeSettings);
      case login:
        return LoginScreen.route(routeSettings);
      case forgotPassword:
        return ForgotPasswordScreen.route(routeSettings);
      case signup:
        return SignupScreen.route(routeSettings);

      case completeProfile:
        return UserProfileScreen.route(routeSettings);

      case categories:
        return CategoryList.route(routeSettings);
      case subCategoryScreen:
        return SubCategoryScreen.route(routeSettings);
      case categoryFilterScreen:
        return CategoryFilterScreen.route(routeSettings);
      case subCategoryFilterScreen:
        return SubCategoryFilterScreen.route(routeSettings);
      case postedSinceFilterScreen:
        return PostedSinceFilterScreen.route(routeSettings);
      case maintenanceMode:
        return MaintenanceMode.route(routeSettings);
      case languageListScreenRoute:
        return LanguagesListScreen.route(routeSettings);

      case contactUs:
        return ContactUs.route(routeSettings);
      case profileSettings:
        return ProfileSettings.route(routeSettings);
      case filterScreen:
        return FilterScreen.route(routeSettings);
      case notificationPage:
        return Notifications.route(routeSettings);
      case notificationDetailPage:
        return NotificationDetail.route(routeSettings);
      case chooseLocaitonMap:
        return ChooseLocationMap.route(routeSettings);
      case articlesScreenRoute:
        return ArticlesScreen.route(routeSettings);
      case successItemScreen:
        return SuccessItemScreen.route(routeSettings);

      case articleDetailsScreenRoute:
        return ArticleDetails.route(routeSettings);
      case subscriptionPackageListRoute:
        return SubscriptionPackageListScreen.route(routeSettings);

      case favoritesScreen:
        return FavoriteScreen.route(routeSettings);

      case transactionHistory:
        return TransactionHistory.route(routeSettings);
      case blockedUserListScreen:
        return BlockedUserListScreen.route(routeSettings);

      case myAdvertisment:
        return MyAdvertisementScreen.route(routeSettings);
      case myItemScreen:
        return ItemsScreen.route(routeSettings);
      case searchScreenRoute:
        return SearchScreen.route(routeSettings);

      case itemsList:
        return ItemsList.route(routeSettings);

      //Add item screen
      case selectCategoryScreen:
        return SelectCategoryScreen.route(routeSettings);
      case selectNestedCategoryScreen:
        return SelectNestedCategory.route(routeSettings);
      case addItemDetails:
        return AddItemDetails.route(routeSettings);
      case addMoreDetailsScreen:
        return AddMoreDetailsScreen.route(routeSettings);

      case confirmLocationScreen:
        return ConfirmLocationScreen.route(routeSettings);
      case sectionWiseItemsScreen:
        return SectionItemsScreen.route(routeSettings);

      case adDetailsScreen:
        return AdDetailsScreen.route(routeSettings);

      case pdfViewerScreen:
        return PdfViewer.route(routeSettings);

      /*  case myItemsScreen:
        return ItemsScreen.route(routeSettings);*/

      case introSliderScreen:
        return CupertinoPageRoute(
          builder: (_) => const IntroSliderScreen(),
        );

      case splashScreen:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case loginScreen:
        return CupertinoPageRoute(
          builder: (_) => LoginAccount(from: routeSettings.arguments as String?),
        );

      case otpScreen:
        List<dynamic> firebaseArguments = routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => OtpVerificationScreen(
            firebaseAuth: firebaseArguments[0] as FirebaseAuth,
            otpVerificationId: firebaseArguments[1] as String,
            phoneNumber: firebaseArguments[2] as String,
            selectedCountryCode: firebaseArguments[3] as CountryCode,
            from: firebaseArguments[4] as String?,
          ),
        );

      case webViewScreen:
        return CupertinoPageRoute(
          builder: (_) => WebViewScreen(dataFor: routeSettings.arguments as String),
        );

      case editProfileScreen:
        return CupertinoPageRoute(
          builder: (_) => EditProfile(from: routeSettings.arguments as String),
        );

    // case getLocationScreen:
    //   return CupertinoPageRoute(
    //     builder: (_) => GetLocation(from: settings.arguments as String),
    //   );

      case confirmLocationScreeneCom:
        List<dynamic> confirmLocationArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ConfirmLocation(
            address: confirmLocationArguments[0],
            from: confirmLocationArguments[1] as String,
          ),
        );

      case mainHomeScreen:
        return CupertinoPageRoute(
          builder: (_) => HomeMainScreen(/*key: Constant.navigatorKay*/),
        );

      case subCategoryListScreen:
        List<dynamic> subCategoryArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<CategoryListProvider>(
            create: (context) => CategoryListProvider(),
            child: SubCategoryListScreen(
              categoryName: subCategoryArguments[0] as String,
              categoryId: subCategoryArguments[1] as String,
            ),
          ),
        );

      case brandListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<BrandListProvider>(
            create: (context) => BrandListProvider(),
            child: BrandListScreen(),
          ),
        );

      case sellerListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<SellerListProvider>(
            create: (context) => SellerListProvider(),
            child: SellerListScreen(),
          ),
        );

      case cartScreen:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => PromoCodeProvider(),
              ),
            ],
            child: const CartListScreen(),
          ),
        );

      case checkoutScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider(),
            child: const CheckoutScreen(),
          ),
        );

      case promoCodeScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<PromoCodeProvider>(
            create: (context) => PromoCodeProvider(),
            child: PromoCodeListScreen(amount: routeSettings.arguments as double),
          ),
        );

      case productListScreen:
        List<dynamic> productListArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductListProvider>(
            create: (context) => ProductListProvider(),
            child: ProductListScreen(
              from: productListArguments[0] as String,
              id: productListArguments[1] as String,
              title: GeneralMethods.setFirstLetterUppercase(
                productListArguments[2],
              ),
            ),
          ),
        );

      case productSearchScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductSearchProvider>(
            create: (context) => ProductSearchProvider(),
            child: const ProductSearchScreen(),
          ),
        );

      case productListFilterScreen:
        List<dynamic> productListFilterArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductFilterProvider>(
            create: (context) => ProductFilterProvider(),
            child: ProductListFilterScreen(
              brands: productListFilterArguments[0] as List<Brands>,
              maxPrice: productListFilterArguments[1] as double,
              minPrice: productListFilterArguments[2] as double,
              sizes: productListFilterArguments[3] as List<Sizes>,
            ),
          ),
        );

      case productDetailScreen:
        List<dynamic> productDetailArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductDetailProvider>(
            create: (context) => ProductDetailProvider(),
            child: ProductDetailScreen(
              id: productDetailArguments[0] as String,
              title: productDetailArguments[1] as String,
              productListItem: productDetailArguments[2],
            ),
          ),
        );

      case fullScreenProductImageScreen:
        List<dynamic> productFullScreenImagesScreen =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ProductFullScreenImagesScreen(
            initialPage: productFullScreenImagesScreen[0] as int,
            images: productFullScreenImagesScreen[1] as List<String>,
          ),
        );

      case addressListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider(),
            child: AddressListScreen(
              from: routeSettings.arguments as String,
            ),
          ),
        );

      case addressDetailScreen:
        List<dynamic> addressDetailArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider(),
            child: AddressDetailScreen(
              address: addressDetailArguments[0],
              addressProviderContext: addressDetailArguments[1] as BuildContext,
            ),
          ),
        );

      case orderHistoryScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ActiveOrdersProvider>(
            create: (context) => ActiveOrdersProvider(),
            child: const OrdersHistoryScreen(),
          ),
        );

      case orderDetailScreen:
        List<dynamic> orderDetailScreenArguments =
        routeSettings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => OrderInvoiceProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => CurrentOrderProvider(),
              )
            ],
            child: OrderSummaryScreen(
              order: orderDetailScreenArguments[0] as Order,
            ),
          ),
        );

      case notificationListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider(),
            child: const NotificationListScreen(),
          ),
        );

      case transactionListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<TransactionProvider>(
            create: (context) => TransactionProvider(),
            child: const TransactionListScreen(),
          ),
        );

      case walletHistoryListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<WalletHistoryProvider>(
            create: (context) => WalletHistoryProvider(),
            child: const WalletHistoryListScreen(),
          ),
        );

      case faqListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<FaqProvider>(
            create: (context) => FaqProvider(),
            child: const FaqListScreen(),
          ),
        );

      case notificationsAndMailSettingsScreenScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<NotificationsSettingsProvider>(
            create: (context) => NotificationsSettingsProvider(),
            child: const NotificationsAndMailSettingsScreenScreen(),
          ),
        );

      case orderPlaceScreen:
        return CupertinoPageRoute(
          builder: (_) => const OrderPlacedScreen(),
        );

      case underMaintenanceScreen:
        return CupertinoPageRoute(
          builder: (_) => const UnderMaintenanceScreen(),
        );

      case appUpdateScreen:
        return CupertinoPageRoute(
          builder: (_) =>
              AppUpdateScreen(canIgnoreUpdate: routeSettings.arguments as bool),
        );

      case paypalPaymentScreen:
        return CupertinoPageRoute(
          builder: (_) =>
              PayPalPaymentScreen(paymentUrl: routeSettings.arguments as String),
        );
      case playground:
        return CupertinoPageRoute(builder: (context) => const Scaffold());
      default:
        return CupertinoPageRoute(builder: (context) => const Scaffold());
    }
  }
}
