import 'package:eClassify/wwlcommerce/helper/generalWidgets/sellerItemContainer.dart';
import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;

  const HomeScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //fetch productList from api
    Future.delayed(Duration.zero).then(
      (value) async {
        await getAppSettings(context: context);

        Map<String, String> params = await Constant.getProductsDefaultParams();
        await context
            .read<HomeScreenProvider>()
            .getHomeScreenApiProvider(context: context, params: params);

        if (Constant.session.getBoolData(SessionManager.isUserLogin)) {
          await context
              .read<CartListProvider>()
              .getAllCartItems(context: context);

          await getUserDetail(context: context).then(
            (value) {
              if (value[ApiAndParams.status].toString() == "1") {
                context
                    .read<UserProfileProvider>()
                    .updateUserDataInSession(value, context);
              }
            },
          );
        }
        final PendingDynamicLinkData? initialLink =
            await FirebaseDynamicLinks.instance.getInitialLink();

        if (initialLink != null) {
          final Uri deepLink = initialLink.link;
          if (deepLink.path.split("/")[1] == "product") {
            Navigator.pushNamed(
              context,
              productDetailScreen,
              arguments: [
                deepLink.path.split("/")[2].toString(),
                getTranslatedValue(
                  context,
                  "product_detail",
                ),
                null
              ],
            );
          }
        }

        FirebaseDynamicLinks.instance.onLink.listen(
          (dynamicLinkData) {
            if (dynamicLinkData.link.path.split("/")[1] == "product") {
              Navigator.pushNamed(
                context,
                productDetailScreen,
                arguments: [
                  dynamicLinkData.link.path.split("/")[2].toString(),
                  getTranslatedValue(
                    context,
                    "product_detail",
                  ),
                  null
                ],
              );
            }
          },
        );
      },
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: deliverAddressWidget(),
        centerTitle: false,
        actions: [setCartCounter(context: context)],
        showBackButton: false,
      ),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () async {
                Map<String, String> params =
                    await Constant.getProductsDefaultParams();
                return await context
                    .read<HomeScreenProvider>()
                    .getHomeScreenApiProvider(context: context, params: params);
              },
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Consumer<HomeScreenProvider>(
                  builder: (context, homeScreenProvider, _) {
                    Map<String, List<String>> map =
                        homeScreenProvider.homeOfferImagesMap;
                    if (homeScreenProvider.homeScreenState ==
                        HomeScreenState.loaded) {
                      return Column(
                        children: [
                          //top offer images
                          if (map.containsKey("top"))
                            getOfferImages(map["top"]!.toList()),
                          ChangeNotifierProvider<SliderImagesProvider>(
                            create: (context) => SliderImagesProvider(),
                            child: SliderImageWidget(
                              sliders:
                                  homeScreenProvider.homeScreenData.sliders ??
                                      [],
                            ),
                          ),
                          //below slider offer images
                          if (map.containsKey("below_slider"))
                            getOfferImages(map["below_slider"]!.toList()),
                          if (homeScreenProvider.homeScreenData.category !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.category!.isNotEmpty)
                            categoryWidget(
                                homeScreenProvider.homeScreenData.category),
                          //below category offer images
                          if (map.containsKey("below_category"))
                            getOfferImages(map["below_category"]!.toList()),
                          if (homeScreenProvider.homeScreenData.brand != null &&
                              homeScreenProvider
                                  .homeScreenData.brand!.isNotEmpty)
                            brandWidget(
                                homeScreenProvider.homeScreenData.brand),
                          if (homeScreenProvider.homeScreenData.sellers !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.sellers!.isNotEmpty)
                            sellerWidget(
                                homeScreenProvider.homeScreenData.sellers),
                          if (homeScreenProvider.homeScreenData.sections !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.sections!.isNotEmpty)
                            sectionWidget(
                                homeScreenProvider.homeScreenData.sections)
                        ],
                      );
                    } else if (homeScreenProvider.homeScreenState ==
                            HomeScreenState.loading ||
                        homeScreenProvider.homeScreenState ==
                            HomeScreenState.initial) {
                      return getHomeScreenShimmer();
                    } else {
                      return NoInternetConnectionScreen(
                        height: context.height * 0.65,
                        message: homeScreenProvider.message,
                        callback: () async {
                          Map<String, String> params =
                              await Constant.getProductsDefaultParams();
                          await context
                              .read<HomeScreenProvider>()
                              .getHomeScreenApiProvider(
                                  context: context, params: params);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// APP BAR UI STARTS
  deliverAddressWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, confirmLocationScreeneCom,
            arguments: [null, "location"]).then((value) async {
          if (value == null) {
            Map<String, String> params =
                await Constant.getProductsDefaultParams();
            return await context
                .read<HomeScreenProvider>()
                .getHomeScreenApiProvider(context: context, params: params);
          }
        });
      },
      child: ListTile(
        contentPadding: EdgeInsetsDirectional.zero,
        horizontalTitleGap: 0,
        leading: Widgets.getDarkLightIcon(
            image: "home_map",
            height: 35,
            width: 35,
            padding: EdgeInsetsDirectional.only(
                top: Constant.size10,
                bottom: Constant.size10,
                end: Constant.size10)),
        title: CustomTextLabel(
          jsonKey: "delivery_to",
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 15,
              color: ColorsRes.mainTextColor,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Constant.session.getData(SessionManager.keyAddress).isNotEmpty
            ? CustomTextLabel(
                text: Constant.session.getData(SessionManager.keyAddress),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              )
            : CustomTextLabel(
                jsonKey: "add_new_address",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              ),
      ),
    );
  }

// APP BAR UI ENDS

// HOME PAGE UI STARTS

//categoryList ui
  categoryWidget(List<CategoryItem>? categories) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Theme.of(context).cardColor,
          surfaceTintColor: Theme.of(context).cardColor,
          elevation: 0,
          margin: EdgeInsetsDirectional.only(
            start: Constant.size10,
            end: Constant.size10,
            top: Constant.size10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size5, vertical: Constant.size5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextLabel(
                        jsonKey: "categories",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorsRes.appColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Widgets.getSizedBox(
                        height: Constant.size5,
                      ),
                      CustomTextLabel(
                        jsonKey: "shop_by_categories",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorsRes.subTitleMainTextColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<HomeMainScreenProvider>().selectBottomMenu(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: DesignConfig.boxDecoration(
                      ColorsRes.appColorLightHalfTransparent,
                      5,
                      bordercolor: ColorsRes.appColor,
                      isboarder: true,
                      borderwidth: 1,
                    ),
                    child: CustomTextLabel(
                      jsonKey: "see_all",
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorsRes.appColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
            color: Theme.of(context).cardColor,
            surfaceTintColor: Theme.of(context).cardColor,
            elevation: 0,
            margin: EdgeInsetsDirectional.only(
                start: Constant.size10,
                end: Constant.size10,
                top: Constant.size10,
                bottom: Constant.size5),
            child: GridView.builder(
              itemCount: categories?.length,
              padding: EdgeInsets.symmetric(
                  horizontal: Constant.size10, vertical: Constant.size10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                CategoryItem category = categories![index];
                return CategoryItemContainer(
                    category: category,
                    voidCallBack: () {
                      if (category.hasChild!) {
                        Navigator.pushNamed(context, subCategoryListScreen,
                            arguments: [category.name, category.id.toString()]);
                      } else {
                        Navigator.pushNamed(context, productListScreen,
                            arguments: [
                              "category",
                              category.id.toString(),
                              category.name
                            ]);
                      }
                    });
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            ))
      ],
    );
  }

//brand ui
  brandWidget(List<Brand>? brands) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Theme.of(context).cardColor,
          surfaceTintColor: Theme.of(context).cardColor,
          elevation: 0,
          margin: EdgeInsetsDirectional.only(
            start: Constant.size10,
            end: Constant.size10,
            top: Constant.size10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size5, vertical: Constant.size5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextLabel(
                        jsonKey: "brands",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorsRes.appColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Widgets.getSizedBox(
                        height: Constant.size5,
                      ),
                      CustomTextLabel(
                        jsonKey: "shop_by_brands",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorsRes.subTitleMainTextColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      brandListScreen,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: DesignConfig.boxDecoration(
                      ColorsRes.appColorLightHalfTransparent,
                      5,
                      bordercolor: ColorsRes.appColor,
                      isboarder: true,
                      borderwidth: 1,
                    ),
                    child: CustomTextLabel(
                      jsonKey: "see_all",
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorsRes.appColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          color: Theme.of(context).cardColor,
          surfaceTintColor: Theme.of(context).cardColor,
          elevation: 0,
          margin: EdgeInsetsDirectional.only(
              start: Constant.size10,
              end: Constant.size10,
              top: Constant.size10,
              bottom: Constant.size5),
          child: GridView.builder(
            itemCount: brands?.length,
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size10, vertical: Constant.size10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Brand? brand = brands?[index];
              return BrandItemContainer(
                  brand: brand,
                  voidCallBack: () {
                    Navigator.pushNamed(context, productListScreen, arguments: [
                      "brand",
                      brand?.id.toString(),
                      brand?.name
                    ]);
                  });
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          ),
        )
      ],
    );
  }

//seller ui
  sellerWidget(List<Sellers>? sellers) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Theme.of(context).cardColor,
          surfaceTintColor: Theme.of(context).cardColor,
          elevation: 0,
          margin: EdgeInsetsDirectional.only(
            start: Constant.size10,
            end: Constant.size10,
            top: Constant.size10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size5, vertical: Constant.size5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextLabel(
                        jsonKey: "sellers",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorsRes.appColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Widgets.getSizedBox(
                        height: Constant.size5,
                      ),
                      CustomTextLabel(
                        jsonKey: "shop_by_sellers",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorsRes.subTitleMainTextColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      sellerListScreen,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: DesignConfig.boxDecoration(
                      ColorsRes.appColorLightHalfTransparent,
                      5,
                      bordercolor: ColorsRes.appColor,
                      isboarder: true,
                      borderwidth: 1,
                    ),
                    child: CustomTextLabel(
                      jsonKey: "see_all",
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorsRes.appColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          color: Theme.of(context).cardColor,
          surfaceTintColor: Theme.of(context).cardColor,
          elevation: 0,
          margin: EdgeInsetsDirectional.only(
              start: Constant.size10,
              end: Constant.size10,
              top: Constant.size10,
              bottom: Constant.size5),
          child: GridView.builder(
            itemCount: sellers?.length,
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size10, vertical: Constant.size10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Sellers? seller = sellers?[index];
              return SellerItemContainer(
                seller: seller,
                voidCallBack: () {
                  Navigator.pushNamed(context, productListScreen, arguments: [
                    "seller",
                    seller?.id.toString(),
                    seller?.name
                  ]);
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          ),
        )
      ],
    );
  }

//sectionList ui
  sectionWidget(List<Sections>? sections) {
    return Column(
      children: List.generate(sections?.length ?? 0, (index) {
        Sections? section = sections?[index];
        return section!.products!.isNotEmpty
            ? Column(
                children: [
                  Card(
                    color: Theme.of(context).cardColor,
                    surfaceTintColor: Theme.of(context).cardColor,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(
                        horizontal: Constant.size10, vertical: Constant.size5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constant.size5, vertical: Constant.size5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextLabel(
                                  text: section.title,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: ColorsRes.appColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Widgets.getSizedBox(
                                  height: Constant.size5,
                                ),
                                CustomTextLabel(
                                  text: section.shortDescription,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorsRes.subTitleMainTextColor),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, productListScreen,
                                  arguments: [
                                    "sections",
                                    section.id.toString(),
                                    section.title
                                  ]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: DesignConfig.boxDecoration(
                                ColorsRes.appColorLightHalfTransparent,
                                5,
                                bordercolor: ColorsRes.appColor,
                                isboarder: true,
                                borderwidth: 1,
                              ),
                              child: CustomTextLabel(
                                jsonKey: "see_all",
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: ColorsRes.appColor,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: context.width),
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: Row(
                        children: List.generate(section.products?.length ?? 0,
                            (index) {
                          ProductListItem product = section.products![index];
                          return HomeScreenProductListItem(
                            product: product,
                            position: index,
                          );
                        }),
                      ),
                    ),
                  ),
                  //below section offer images
                  if (context
                      .read<HomeScreenProvider>()
                      .homeOfferImagesMap
                      .containsKey("below_section-${section.id}"))
                    getOfferImages(context
                        .read<HomeScreenProvider>()
                        .homeOfferImagesMap["below_section-${section.id}"]
                        ?.toList()),
                ],
              )
            : Container();
      }),
    );
  }

  Widget getHomeScreenShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Constant.size10, horizontal: Constant.size10),
      child: Column(
        children: [
          CustomShimmer(
            height: context.height * 0.26,
            width: context.width,
          ),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          CustomShimmer(
            height: Constant.size10,
            width: context.width,
          ),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          getCategoryShimmer(
              context: context, count: 6, padding: EdgeInsets.zero),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          Column(
            children: List.generate(5, (index) {
              return Column(
                children: [
                  const CustomShimmer(height: 50),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Constant.size10,
                              horizontal: Constant.size5),
                          child: CustomShimmer(
                            height: 210,
                            width: context.width * 0.4,
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

// HOME PAGE UI ENDS
}
