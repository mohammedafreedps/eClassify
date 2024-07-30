import 'dart:async';
import 'dart:convert';


import 'package:eClassify/Utils/hive_keys.dart';
import 'package:eClassify/app/app_theme.dart';
import 'package:eClassify/data/cubits/item/fetch_popular_items_cubit.dart';
import 'package:eClassify/data/cubits/item/search_Item_cubit.dart';
import 'package:eClassify/data/model/item_filter_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../Utils/api.dart';

import '../../../data/cubits/system/app_theme_cubit.dart';
import '../../../data/helper/designs.dart';
import '../../../data/model/item/item_model.dart';
import '../../../exports/main_export.dart';
import '../Widgets/Errors/no_data_found.dart';
import '../Widgets/Errors/no_internet.dart';
import '../Widgets/shimmerLoadingContainer.dart';
import '../home/home_screen.dart';
import 'Widgets/item_horizontal_card.dart';
import '../widgets/AnimatedRoutes/blur_page_route.dart';
import '../widgets/Errors/something_went_wrong.dart';
import '../../../utils/AppIcon.dart';
import '../../../utils/Extensions/extensions.dart';
import '../../../utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/routes.dart';
import '../../../utils/ui_utils.dart';

class SearchScreen extends StatefulWidget {
  final bool autoFocus;

  const SearchScreen({
    super.key,
    required this.autoFocus,
  });

  static Route route(RouteSettings settings) {
    Map? arguments = settings.arguments as Map?;

    return BlurredRouter(
      builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SearchItemCubit(),
            ),
            BlocProvider(
              create: (context) => FetchPopularItemsCubit(),
            ),
          ],
          child: SearchScreen(
            autoFocus: arguments?['autoFocus'],
          )),
    );
  }

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;
  bool isFocused = false;
  String previousSearchQuery = "";
  static TextEditingController searchController = TextEditingController();
  final ScrollController controller = ScrollController();
  final ScrollController popularController = ScrollController();
  Timer? _searchDelay;
  ItemFilterModel? filter;

  @override
  void initState() {
    super.initState();

    context.read<FetchPopularItemsCubit>().fetchPopularItems();
    // context.read<ItemCubit>().fetchItem(context, {});
    //context.read<SearchItemCubit>().searchItem("", page: 1);
    searchController = TextEditingController();

    searchController.addListener(searchItemListener);
    controller.addListener(pageScrollListen);
    popularController.addListener(pagePopularScrollListen);
  }

  void pageScrollListen() {
    if (controller.isEndReached()) {
      if (context.read<SearchItemCubit>().hasMoreData()) {
        context
            .read<SearchItemCubit>()
            .fetchMoreSearchData(searchController.text, Constant.itemFilter);
      }
    }
  }

  void pagePopularScrollListen() {
    if (popularController.isEndReached()) {
      if (context.read<FetchPopularItemsCubit>().hasMoreData()) {
        context.read<FetchPopularItemsCubit>().fetchMyMoreItems();
      }
    }
  }

//this will listen and manage search
  void searchItemListener() {
    _searchDelay?.cancel();
    searchCallAfterDelay();
    setState(() {});
  }

//This will create delay so we don't face rapid api call
  void searchCallAfterDelay() {
    _searchDelay = Timer(const Duration(milliseconds: 500), itemSearch);
  }

  ///This will call api after some delay
  void itemSearch() {
    // if (searchController.text.isNotEmpty) {
    if (previousSearchQuery != searchController.text) {
      context.read<SearchItemCubit>().searchItem(
            searchController.text,
            page: 1,
          );
      previousSearchQuery = searchController.text;
      setState(() {});
    }
    // } else {
    // context.read<SearchItemCubit>().clearSearch();
    // }
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: context.color.backgroundColor),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.rh(context)),
          child: LayoutBuilder(builder: (context, c) {
            return SizedBox(
                width: c.maxWidth,
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 270.rw(context),
                            height: 50.rh(context),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: context
                                                .watch<AppThemeCubit>()
                                                .state
                                                .appTheme ==
                                            AppTheme.dark
                                        ? 0
                                        : 1,
                                    color:
                                        context.color.borderColor.darken(30)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: context.color.secondaryColor),
                            child: TextFormField(
                                autofocus: widget.autoFocus,
                                controller: searchController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  //OutlineInputBorder()
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryColor,
                                  hintText: "searchHintLbl".translate(context),
                                  prefixIcon: setSearchIcon(),
                                  prefixIconConstraints: const BoxConstraints(
                                      minHeight: 5, minWidth: 5),
                                ),
                                enableSuggestions: true,
                                onEditingComplete: () {
                                  setState(
                                    () {
                                      isFocused = false;
                                    },
                                  );
                                  FocusScope.of(context).unfocus();
                                },
                                onTap: () {
                                  //change prefix icon color to primary
                                  setState(() {
                                    isFocused = true;
                                  });
                                })),
                        const SizedBox(
                          width: 14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.filterScreen,
                                arguments: {
                                  "update": getFilterValue,
                                  "from": "search"
                                }).then((value) {
                              if (value == true) {
                                context.read<SearchItemCubit>().searchItem(
                                    searchController.text,
                                    page: 1,
                                    filter: filter);
                              }
                            });
                          },
                          child: Container(
                            width: 50.rw(context),
                            height: 50.rh(context),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: context.color.borderColor.darken(30)),
                              color: context.color.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: UiUtils.getSvg(AppIcons.filter,
                                  color: context.color.territoryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          })),
      automaticallyImplyLeading: false,
      leading: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        type: MaterialType.circle,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 18.0, top: 12),
            child: UiUtils.getSvg(AppIcons.arrowLeft,
                fit: BoxFit.none, color: context.color.textDefaultColor),
          ),
        ),
      ),
      /*BackButton(
        color: context.color.textDefaultColor,
      ),*/
      elevation: context.watch<AppThemeCubit>().state.appTheme == AppTheme.dark
          ? 0
          : 6,
      shadowColor:
          context.watch<AppThemeCubit>().state.appTheme == AppTheme.dark
              ? null
              : context.color.textDefaultColor.withOpacity(0.2),
      backgroundColor: context.color.backgroundColor,
    );
  }

  getFilterValue(ItemFilterModel model) {
    filter = model;
    setState(() {});
  }

  ListView shimmerEffect() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 10 + defaultPadding,
        horizontal: defaultPadding,
      ),
      itemCount: 5,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: CustomShimmer(height: 90, width: 90),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, c) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      CustomShimmer(
                        height: 10,
                        width: c.maxWidth - 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomShimmer(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomShimmer(
                        height: 10,
                        width: c.maxWidth / 1.2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: CustomShimmer(
                          width: c.maxWidth / 4,
                        ),
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(appBar: appBarWidget(), body: bodyData(),backgroundColor: context.color.backgroundColor,);
  }

  Widget bodyData() {
    return SingleChildScrollView(
      controller:
          searchController.text.isNotEmpty ? controller : popularController,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildHistoryItemList(),
        searchController.text.isNotEmpty
            ? searchItemsWidget()
            : popularItemsWidget(),
      ]),
    );
  }

  void clearBoxData() async {
    var box = Hive.box(HiveKeys.historyBox);
    await box.clear();
    setState(() {});
  }

  Widget buildHistoryItemList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box(HiveKeys.historyBox).listenable(),
      builder: (context, Box box, _) {
        List<ItemModel> items = box.values.map((jsonString) {
          return ItemModel.fromJson(jsonDecode(jsonString));
        }).toList();

        if (items.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("recentSearches".translate(context))
                        .color(context.color.textDefaultColor.withOpacity(0.5)),
                    InkWell(
                      child: Text("clear".translate(context))
                          .color(context.color.territoryColor),
                      onTap: () {
                        clearBoxData();
                      },
                    ),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: context.color.borderColor.darken(30),
                      thickness: 1.2,
                    );
                  },
                  padding: EdgeInsets.only(top: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 22,
                          color: context.color.textDefaultColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: RichText(
                          
                            text: TextSpan(
                              text: "${items[index].name!}\tin\t",
                          
                              style: TextStyle(
                                  color: context.color.textDefaultColor
                                      .withOpacity(0.5),overflow: TextOverflow.ellipsis),
                              children: <TextSpan>[
                                TextSpan(
                                  text: items[index].category!.name,
                          
                                  style: TextStyle(
                                      color: context.color.textDefaultColor,overflow: TextOverflow.ellipsis,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Divider(
                  color: context.color.borderColor.darken(30),
                  thickness: 1.2,
                )
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  void insertNewItem(ItemModel model) {
    var box = Hive.box(HiveKeys.historyBox);

    if (box.length >= 5) {
      box.deleteAt(0);
    }

    box.add(jsonEncode(model.toJson()));

    setState(() {});
  }

  Widget searchItemsWidget() {
    return BlocBuilder<SearchItemCubit, SearchItemState>(
      builder: (context, state) {
        if (state is SearchItemFetchProgress) {
          return shimmerEffect();
        }

        if (state is SearchItemFailure) {
          if (state.errorMessage is ApiException) {
            if (state.errorMessage == "no-internet") {
              return SingleChildScrollView(
                child: NoInternet(
                  onRetry: () {
                    context
                        .read<SearchItemCubit>()
                        .searchItem(searchController.text.toString(), page: 1);
                  },
                ),
              );
            }
          }

          return Center(child: const SomethingWentWrong());
        }

        if (state is SearchItemSuccess) {
          if (state.searchedItems.isEmpty) {
            return SingleChildScrollView(
              child: NoDataFound(
                onTap: () {
                  context
                      .read<SearchItemCubit>()
                      .searchItem(searchController.text.toString(), page: 1);
                },
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: sidePadding,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 5.0),
                  child: Text("searchedItems".translate(context))
                      .color(context.color.textDefaultColor.withOpacity(0.5))
                      .size(context.font.normal),
                ),
                SizedBox(
                  height: 3,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    ItemModel item = state.searchedItems[index];

                    return InkWell(
                      onTap: () {
                        insertNewItem(item);
                        Navigator.pushNamed(
                          context,
                          Routes.adDetailsScreen,
                          arguments: {
                            'model': item,
                          },
                        );
                      },
                      child: ItemHorizontalCard(
                        item: item,
                        showLikeButton: true,
                        additionalImageWidth: 8,
                      ),
                    );
                  },
                  itemCount: state.searchedItems.length,
                ),
                if (state.isLoadingMore)
                  Center(
                    child: UiUtils.progress(
                      normalProgressColor: context.color.territoryColor,
                    ),
                  )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget popularItemsWidget() {
    return BlocBuilder<FetchPopularItemsCubit, FetchPopularItemsState>(
      builder: (context, state) {
        if (state is FetchPopularItemsInProgress) {
          return shimmerEffect();
        }

        if (state is FetchPopularItemsFailed) {
          if (state.error is ApiException) {
            if (state.error.error == "no-internet") {
              return SingleChildScrollView(
                child: NoInternet(
                  onRetry: () {
                    context.read<FetchPopularItemsCubit>().fetchPopularItems();
                  },
                ),
              );
            }
          }

          return const SingleChildScrollView(child: SomethingWentWrong());
        }

        if (state is FetchPopularItemsSuccess) {
          if (state.items.isEmpty) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: sidePadding,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 5.0),
                  child: Text("popularAds".translate(context))
                      .color(context.color.textDefaultColor.withOpacity(0.5))
                      .size(context.font.normal),
                ),
                SizedBox(
                  height: 3,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  /*  padding: const EdgeInsets.symmetric(
                    horizontal: sidePadding,
                    vertical: 8,
                  ),*/

                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    ItemModel item = state.items[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.adDetailsScreen,
                          arguments: {
                            'model': item,
                          },
                        );
                      },
                      child: ItemHorizontalCard(
                        item: item,
                        showLikeButton: true,
                        additionalImageWidth: 8,
                      ),
                    );
                  },
                  itemCount: state.items.length,
                ),
                if (state.isLoadingMore)
                  Center(
                    child: UiUtils.progress(
                      normalProgressColor: context.color.territoryColor,
                    ),
                  )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget setSearchIcon() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UiUtils.getSvg(AppIcons.search,
            color: context.color.territoryColor));
  }

  Widget setSuffixIcon() {
    return GestureDetector(
      onTap: () {
        searchController.clear();
        isFocused = false; //set icon color to black back
        FocusScope.of(context).unfocus(); //dismiss keyboard
        setState(() {});
      },
      child: Icon(
        Icons.close_rounded,
        color: Theme.of(context).colorScheme.blackColor,
        size: 30,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}