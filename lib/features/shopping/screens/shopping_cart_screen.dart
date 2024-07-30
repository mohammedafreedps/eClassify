import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/shopping/controller/shop_controller.dart';
import 'package:eClassify/features/shopping/models/shopping_items_model.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  late Razorpay _razorpay;
  int prices = 0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckout({required String email, required int price}) async {
    var options = {
      'key': 'rzp_test_4VNZTbdIm7GToE',
      'amount': price * 100,
      'name': ' ',
      'description': ' ',
      'prefill': {'contact': '', 'email': email}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) {
    // sendDataToPaymentCollection();
    showSnackBar(context, "successful");
    return ref.read(shopControllerProvider.notifier).delectAllShopCart();
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    showSnackBar(context, "Fail to ${response.message}");
  }

  void handleExternalWallet(PaymentFailureResponse response) {}

  void sendPaymentToRazorPay({required String email, required int price}) {
    setState(() {
      openCheckout(email: email, price: price);
    });
  }

  double calculateTotalPrice(List<ShoppingCartItemsModel> items) {
    double totalPrice = 0.0;
    for (var item in items) {
      totalPrice += item.discountPrize;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ref.watch(getAllShoppingCartItemsProvider).when(
            data: (data) {
              return data.isEmpty
                  ? const Center(
                      child: Text("There Are No Cart Here."),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final shopCart = data[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          shopCart.images.first,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              shopCart.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              "${shopCart.selectedItemCount.toString()} Items",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹${shopCart.discountPrize.floor() * shopCart.selectedItemCount}  ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(
                                                            shopControllerProvider
                                                                .notifier)
                                                        .delectShopCart(
                                                            docId: shopCart.id);
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.delete,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                double totalPrice = calculateTotalPrice(data);
                                sendPaymentToRazorPay(
                                  email: user.email,
                                  price: totalPrice.toInt(),
                                );
                                // Navigator.of(context).push(
                                //   CupertinoPageRoute(
                                //     builder: (context) =>
                                //         const ShoppingCartDetailsScreen(),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Pallete.borderColor),
                                ),
                              ),
                              child: const Text(
                                "Pay Now",
                                style: TextStyle(color: Pallete.blackColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    );
            },
            error: (error, st) {
              return ErrorText(
                error: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
