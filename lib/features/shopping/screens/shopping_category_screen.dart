import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/shopping/controller/shop_controller.dart';
import 'package:eClassify/features/shopping/models/shopping_item_content.dart';
import 'package:eClassify/features/shopping/screens/shopping_cart_screen.dart';
import 'package:eClassify/features/shopping/screens/shopping_screen.dart';

class ShoppingCategoryScreen extends ConsumerStatefulWidget {
  const ShoppingCategoryScreen({super.key});

  @override
  ConsumerState<ShoppingCategoryScreen> createState() =>
      _ShoppingCategoryScreenState();
}

class _ShoppingCategoryScreenState
    extends ConsumerState<ShoppingCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop By Category",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const ShoppingCartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.cart,
                  ),
                ),
                ref.watch(getAllShoppingCartItemsProvider).when(
                      data: (data) {
                        return Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Pallete.greenColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: Text(
                                data.length.toString(),
                                style:
                                    const TextStyle(color: Pallete.whiteColor),
                              ),
                            ),
                          ),
                        );
                      },
                      error: (error, st) {
                        return ErrorScreen(
                          error: error.toString(),
                        );
                      },
                      loading: () => const Text(''),
                    ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: shopCategoryContents.length,
          itemBuilder: (context, index) {
            final contents = shopCategoryContents[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (content) => contents.screen,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Pallete.blueColor.withOpacity(0.07),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 4),
                    Image.asset(
                      contents.imagePath,
                      height: 40,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      contents.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShopCategoryContent {
  final String title;
  final String imagePath;
  final Widget screen;

  ShopCategoryContent({
    this.title = '',
    this.imagePath = '',
    required this.screen,
  });
}

List<ShopCategoryContent> shopCategoryContents = [
  ShopCategoryContent(
    title: "Fruits &\nVegetables",
    imagePath: "assets/home/vegetables.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Foodgrains\nOil & Masala",
    imagePath: "assets/home/masala.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Snacks &\nBranded Foods",
    imagePath: "assets/home/snacks.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Egg Meet\n&Fish",
    imagePath: "assets/home/egg.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Beverages",
    imagePath: "assets/home/beverages.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Bakery, Cakes\n& Dairy",
    imagePath: "assets/home/cake.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  // ShopCategoryContent(
  //   title: "Cleaning &\nHousehold",
  //   imagePath: "assets/home/news.png",
  //   screen: ShoppingScreen(
  //     shoppingList: shoppingItemsModel,
  //   ),
  // ),
  ShopCategoryContent(
    title: "Beauty &\nGrooming",
    imagePath: "assets/home/beauty.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Personal\nCare",
    imagePath: "assets/home/personalcare.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  // ShopCategoryContent(
  //   title: "Kitchen,\nGarden & Pets",
  //   imagePath: "assets/home/news.png",
  //   screen: ShoppingScreen(
  //     shoppingList: shoppingItemsModel,
  //   ),
  // ),
  // ShopCategoryContent(
  //   title: "Gourmet\nWorld food",
  //   imagePath: "assets/home/news.png",
  //   screen: ShoppingScreen(
  //     shoppingList: shoppingItemsModel,
  //   ),
  // ),
  ShopCategoryContent(
    title: "Baby Care",
    imagePath: "assets/home/babycare.jpeg",
    screen: ShoppingScreen(
      shoppingList: shoppingItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Non Veg",
    imagePath: "assets/home/mutton.jpeg",
    screen: ShoppingScreen(
      shoppingList: nonVegItemsModel,
    ),
  ),
  ShopCategoryContent(
    title: "Wines",
    imagePath: "assets/home/wine.jpeg",
    screen: ShoppingScreen(
      shoppingList: winesItemsModel,
    ),
  ),
];
