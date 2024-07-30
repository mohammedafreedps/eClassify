// ignore_for_file: non_constant_identifier_names, file_names

class AppIcons {
  //
  AppIcons._();

  //
  static const String _basePath = "assets/svg/";

  //
  static final MainIcons main = MainIcons();

  //
  //** */
  static String splashLogo = _svgPath("Logo/splashlogo");
  static String magic = _svgPath("magic");
  static String bin = _svgPath("bin");
  static String chat = _svgPath("inactive_chat");
  static String update = _svgPath("update");
  static String companyLogo = _svgPath("Logo/company_logo");
  static String home = _svgPath("home");
  static String profile = _svgPath("profile");
  static String search = _svgPath("search");
  static String items = _svgPath("items");
  static String iconArrowLeft = _svgPath("icon_arrow_left");
  static String filter = _svgPath("filter");
  static String location = _svgPath("location");
  static String downArrow = _svgPath("dropdown");
  static String arrowRight = _svgPath("arrow_right");
  static String homeDark = _svgPath("home_dark");
  static String like = _svgPath("like");
  static String like_fill = _svgPath("like_fill");
  static String enquiry = _svgPath("enquiry");
  static String notification = _svgPath("notification");
  static String language = _svgPath("language");
  static String darkTheme = _svgPath("dark_theme");
  static String subscription = _svgPath("subscription");
  static String articles = _svgPath("article");
  static String favorites = _svgPath("like_fill");
  static String shareApp = _svgPath("share");
  static String areaConvertor = _svgPath("area_convertor");
  static String rateUs = _svgPath("rate_us");
  static String contactUs = _svgPath("contact_us");
  static String aboutUs = _svgPath("about_us");
  static String terms = _svgPath("t_c");
  static String privacy = _svgPath("privacypolicy");
  static String delete = _svgPath("delete_account");
  static String logout = _svgPath("logout");
  static String edit = _svgPath("edit");
  static String call = _svgPath("call");
  static String message = _svgPath("message");
  static String defaultPersonLogo = _svgPath("defaultProfileIcon");
  static String arrowLeft = _svgPath("arrow_left");
  static String warning = _svgPath("warning");
  static String done = _svgPath("done");
  static String promoted = _svgPath("promoted");
  static String headerCurve = _svgPath("header_curve");
  static String v360Degree = _svgPath("v360");
  static String deleteGirlSvg = _svgPath("delete");
  static String logoutDoor = _svgPath("logout_door");
  static String forRent = _svgPath("for_rent");
  static String forSale = _svgPath("for_sale");
  static String homeLogo = _svgPath("Logo/homelogo");
  static String placeHolder = _svgPath("Logo/placeholder");
  static String noInternet = _svgPath("no_internet_illustrator");
  static String somethingWentWrong = _svgPath("something_went_wrong");
  static String itemMap = _svgPath("itemmap");
  static String calender = _svgPath("calender");
  static String interested = _svgPath("interested");
  static String paystack = _svgPath("paystack");
  static String razorpay = _svgPath("razorpay");
  static String paypal = _svgPath("paypal");
  static String transaction = _svgPath("transaction");
  static String reportDark = _svgPath("report_dark");
  static String report = _svgPath("report");
  static String itemSubmittedc = _svgPath("itemsubmited");
  static String plusIcon = _svgPath("plus_button");
  static String no_chat_found = _svgPath("no_chat_found");
  static String no_data_found = _svgPath("no_data_found_illustrator");
  static String locationPin = _svgPath("location_pin");
  static String eye = _svgPath("eye");
  static String heart = _svgPath("heart");
  static String more = _svgPath("more");
  static String ads = _svgPath("ads");
  static String days = _svgPath("days");
  static String itemLimites = _svgPath("item_limites");
  static String verificationMail = _svgPath("Illustrators/mail_verification");
  static String no_internet = _svgPath("no_internet_illustrator");
  static String deleteIcon = _svgPath("delete_illustrator");
  static String logoutIcon = _svgPath("logout_illustrator");
  static String createAddIcon = _svgPath("create_add");

  static String active_mark = _svgPath("active_mark");
  static String deactive_mark = _svgPath("deactive_mark");
  static String cityIcon = _svgPath("City");
  static String locationIcon = _svgPath("location_icon");
  static String categoryIcon = _svgPath("category_icon");
  static String sinceIcon = _svgPath("since_icon");
  static String listViewIcon = _svgPath("list_view");
  static String gridViewIcon = _svgPath("grid_view");
  static String filterByIcon = _svgPath("filter_by");
  static String sortByIcon = _svgPath("sort_by");
  static String appleIcon = _svgPath("apple_icon");
  static String googleIcon = _svgPath("google_icon");
  static String pdfIcon = _svgPath("pdf");
  static String locationAccessIcon = _svgPath("location_access");
  static String safetyTipsIcon = _svgPath("safety_tips");
  static String blockedUserIcon = _svgPath("blockuser");

  ///Bottom nav icons
  static String homeNav = _svgPath("bottomnav/home");
  static String homeNavActive = _svgPath("bottomnav/home_active");
  static String chatNav = _svgPath("bottomnav/chat");
  static String chatNavActive = _svgPath("bottomnav/chat_active");
  static String myAdsNav = _svgPath("bottomnav/myads");
  static String myAdsNavActive = _svgPath("bottomnav/myads_active");
  static String profileNav = _svgPath("bottomnav/profile");
  static String profileNavActive = _svgPath("bottomnav/profile_active");

  //on boardings
  static String onBoardingsOne = _svgPath("onbo_a");
  static String onBoardingsTwo = _svgPath("onbo_b");
  static String onBoardingsThree = _svgPath("onbo_c");

  ///
  static String _svgPath(String name) {
    return "$_basePath$name.svg";
  }
}

class MainIcons {
  ////////
  static String _base(String path) {
    return "assets/Icons/$path";
  }

  ////////
  String appIcon = _base("AppIcon/icon.png");
  String splashIcon = _base("SplashIcon/icon.png");
  String placeHolder = _base("Placeholder/icon.png");
  String homeIcon = _base("HomeIcon/icon.png");
}