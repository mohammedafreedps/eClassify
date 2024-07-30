import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class SubCategoryListScreen extends StatefulWidget {
  final categoryName;
  final categoryId;

  const SubCategoryListScreen({
    Key? key,
    this.categoryName,
    this.categoryId,
  }) : super(key: key);

  @override
  State<SubCategoryListScreen> createState() => _SubCategoryListScreenState();
}

class _SubCategoryListScreenState extends State<SubCategoryListScreen> {
  @override
  void initState() {
    super.initState();
    //fetch categoryList from api
    Future.delayed(Duration.zero).then((value) {
      Map<String, String> params = {};
      params[ApiAndParams.categoryId] = widget.categoryId;

      context
          .read<CategoryListProvider>()
          .getCategoryApiProvider(context: context, params: params);
    });
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
          title: CustomTextLabel(
            text: widget.categoryName,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          actions: [
            setCartCounter(context: context),
          ],
          showBackButton: true),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () {
                Map<String, String> params = {};
                params[ApiAndParams.categoryId] = widget.categoryId;

                return context
                    .read<CategoryListProvider>()
                    .getCategoryApiProvider(context: context, params: params);
              },
              child: ListView(
                children: [categoryWidget()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //categoryList ui
  Widget categoryWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            if (categoryListProvider.categoryState == CategoryState.loaded) {
              return Card(
                color: Theme.of(context).cardColor,
                surfaceTintColor: Theme.of(context).cardColor,
                elevation: 0,
                margin: EdgeInsets.symmetric(
                    horizontal: Constant.size10, vertical: Constant.size10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      itemCount: categoryListProvider.categories.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: Constant.size10,
                          vertical: Constant.size10),
                      shrinkWrap: true,
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (BuildContext context, int index) {
                        CategoryItem category =
                            categoryListProvider.categories[index];

                        return CategoryItemContainer(
                          category: category,
                          voidCallBack: () {
                            if (category.hasChild!) {
                              Navigator.pushNamed(
                                  context, subCategoryListScreen, arguments: [
                                category.name,
                                category.id.toString()
                              ]);
                            } else {
                              Navigator.pushNamed(context, productListScreen,
                                  arguments: [
                                    "category",
                                    category.id.toString(),
                                    category.name
                                  ]);
                            }
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                    ),
                  ],
                ),
              );
            } else if (categoryListProvider.categoryState ==
                CategoryState.loading) {
              return getCategoryShimmer(context: context, count: 9);
            } else {
              return NoInternetConnectionScreen(
                height: context.height * 0.65,
                message: categoryListProvider.message,
                callback: () {
                  Map<String, String> params = {};
                  params[ApiAndParams.categoryId] = widget.categoryId;

                  context
                      .read<CategoryListProvider>()
                      .getCategoryApiProvider(context: context, params: params);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
