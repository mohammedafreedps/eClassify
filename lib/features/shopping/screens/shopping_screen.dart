import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/shopping/controller/shop_controller.dart';
import 'package:eClassify/features/shopping/models/shopping_items_model.dart';
import 'package:eClassify/features/shopping/screens/shopping_cart_screen.dart';
import 'package:eClassify/features/shopping/screens/shopping_items_details_screen.dart';

class ShoppingScreen extends ConsumerWidget {
  final List<ShoppingItemsModel> shoppingList;
  const ShoppingScreen({
    super.key,
    this.shoppingList = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: GridView.builder(
          itemCount: shoppingList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => ShoppingItemDetailsScreen(
                        shoppingList: shoppingList[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Pallete.borderColor)),
                  child: Column(
                    children: [
                      Image.network(
                        shoppingList[index].images.first,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              shoppingList[index].title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "₹${shoppingList[index].discountPrize.floor().toString()}  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹${shoppingList[index].mrpPrize.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Pallete.greyColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
