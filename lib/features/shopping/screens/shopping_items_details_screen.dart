import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/onboarding/widgets/onboarding_button.dart';
import 'package:eClassify/features/shopping/controller/shop_controller.dart';
import 'package:eClassify/features/shopping/models/shopping_items_model.dart';
import 'package:eClassify/features/shopping/screens/shopping_cart_screen.dart';

class ShoppingItemDetailsScreen extends ConsumerStatefulWidget {
  final ShoppingItemsModel shoppingList;
  const ShoppingItemDetailsScreen({
    super.key,
    required this.shoppingList,
  });

  @override
  ConsumerState<ShoppingItemDetailsScreen> createState() =>
      _ShoppingItemDetailsScreenState();
}

class _ShoppingItemDetailsScreenState
    extends ConsumerState<ShoppingItemDetailsScreen> {
  late CarouselController _controller;
  int selectedIteCount = 1;

  @override
  void initState() {
    _controller = CarouselController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage == index
            ? Pallete.blackColor
            : Colors.grey.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 25 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() => _currentPage = index);
                  },
                ),
                items: widget.shoppingList.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            i,
                            frameBuilder: (BuildContext context, Widget child,
                                int? frame, bool? wasSynchronouslyLoaded) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              return child;
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.shoppingList.images.length,
                  (int index) => _buildDots(
                    index: index,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.shoppingList.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "₹${widget.shoppingList.discountPrize.floor().toString()}  ",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " MRP: ",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Pallete.greyColor,
                        ),
                  ),
                  Text(
                    "₹${widget.shoppingList.mrpPrize.toString()}",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Pallete.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete.redColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Text(
                        "${widget.shoppingList.offerPercentage.floor().toString()}% OFF",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              if (widget.shoppingList.packSizes.isNotEmpty)
                Text(
                  "Pack Sizes",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              const SizedBox(height: 8),
              if (widget.shoppingList.packSizes.isNotEmpty)
                SizedBox(
                  child: ListView.builder(
                    itemCount: widget.shoppingList.packSizes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Pallete.borderColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget
                                          .shoppingList.packSizes[index].pieces
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      widget
                                          .shoppingList.packSizes[index].weight,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹${widget.shoppingList.packSizes[index].discountPrize.floor().toString()}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "MRP: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Pallete.greyColor,
                                              ),
                                        ),
                                        Text(
                                          "₹${widget.shoppingList.packSizes[index].mrpPrize.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Pallete.greyColor,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About the Product",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.shoppingList.aboutProduct ?? "",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Pallete.greyColor,
                        ),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benefits",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.shoppingList.benefits ?? "",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Pallete.greyColor,
                        ),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other Product Info",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.shoppingList.otherProductInfo ?? "",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Pallete.greyColor,
                        ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (selectedIteCount > 1) {
                  setState(() {
                    selectedIteCount -= 1;
                  });
                }
              },
              icon: const Icon(CupertinoIcons.minus),
            ),
            Text(
              selectedIteCount.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedIteCount += 1;
                });
              },
              icon: const Icon(CupertinoIcons.add),
            ),
            OnboardingButtonWidget(
              onPressed: () {
                ref
                    .watch(shopControllerProvider.notifier)
                    .saveShoppingCartToFirebase(
                      shoppingCartItemsModel: ShoppingCartItemsModel(
                        title: widget.shoppingList.title,
                        discountPrize: widget.shoppingList.discountPrize,
                        images: widget.shoppingList.images,
                        selectedItemCount: selectedIteCount,
                        id: widget.shoppingList.id,
                        isPaid: false,
                      ),
                      context: context,
                    );
                showModalBottomSheet<void>(
                  // context and builder are
                  // required properties in this widget
                  context: context,
                  builder: (BuildContext context) {
                    // we set up a container inside which
                    // we create center column and display text

                    // Returning SizedBox instead of a Container
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Text(
                              "Added to cart",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OnboardingButtonWidget(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: "Add More",
                                  backgroungColor:
                                      Colors.green.withOpacity(0.2),
                                  textColor: Colors.green,
                                ),
                                OnboardingButtonWidget(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const ShoppingCartScreen(),
                                      ),
                                    );
                                  },
                                  text: "Checkout Cart",
                                  backgroungColor: Pallete.greenColor,
                                  textColor: Pallete.whiteColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              text: "Add to basket",
              backgroungColor: Pallete.greenColor,
              textColor: Pallete.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
