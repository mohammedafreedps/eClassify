import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/shopping/controller/shop_controller.dart';

class ShoppingCartDetailsScreen extends ConsumerStatefulWidget {
  const ShoppingCartDetailsScreen({super.key});

  @override
  ConsumerState<ShoppingCartDetailsScreen> createState() =>
      _ShoppingCartDetailsScreenState();
}

class _ShoppingCartDetailsScreenState
    extends ConsumerState<ShoppingCartDetailsScreen> {
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
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '', 'email': email}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // sendDataToPaymentCollection();
    showSnackBar(context, "successful");
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      shopCart.title,
                                      style: const TextStyle(
                                          color: Pallete.blackColor),
                                    ),
                                    Text(shopCart.discountPrize.toString())
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
                                sendPaymentToRazorPay(
                                  email: user.email,
                                  price: 100,
                                );
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
                        const SizedBox(height: 30)
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
