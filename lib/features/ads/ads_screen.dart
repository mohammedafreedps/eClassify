import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../core/error/loader.dart';
import '../../core/theme/pallete.dart';
import '../../core/utils/pick_image.dart';
import '../../core/utils/snack_bar.dart';
import '../auth/controller/auth_controller.dart';
import '../jobs/screens/recuiter/recuiter_information_screen.dart';
import '../news/controller/news_controller.dart';
import 'ads_controller.dart';
import 'custo_container_widget.dart';


class AddAdsScreen extends ConsumerStatefulWidget {
  const AddAdsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAdsScreen();
}

class _AddAdsScreen extends ConsumerState<AddAdsScreen> {
  final adsTitleController = TextEditingController();
  final adsDescController = TextEditingController();
  XFile? image;
  final formKey = GlobalKey<FormState>();
  bool currentCard = false;
  int price = 0;

  late Razorpay _razorpay;
  // int prices = 0;

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

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // sendDataToPaymentCollection();
    return ref.watch(adsControllerProvider.notifier).sendAdsToFirebase(
          title: adsTitleController.text,
          description: adsDescController.text,
          selectedPrice: price,
          file: image!,
          context: context,
        );
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
    final isLoading = ref.watch(newsControllerProvider);
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ads'),
        actions: [
          TextButton(
            onPressed: () {
              sendPaymentToRazorPay(
                email: user.email,
                price: price,
              );
            },
            child: const Text('Upload'),
          )
        ],
      ),
      body: isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      image != null
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                XFile file = await pickImage();
                                setState(() {
                                  image = file;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Pallete.borderColor.withOpacity(0.5),
                                ),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image_search_outlined,
                                      color: Pallete.icongreyColor,
                                    ),
                                    Text(
                                      "Click here to select a file",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: Pallete.icongreyColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        controller: adsTitleController,
                        title: "Add Title",
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        controller: adsDescController,
                        title: "Add Description",
                        maxLines: null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                price = 100;
                              });
                            },
                            child: CustomContainerWidget(
                              assetsName: "month",
                              title: "Monthly",
                              color: price == 100
                                  ? Pallete.blueColor
                                  : Pallete.borderColor,
                              price: "100",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                price = 300;
                              });
                            },
                            child: CustomContainerWidget(
                              assetsName: "6 month",
                              title: "6 Monthly",
                              color: price == 300
                                  ? Pallete.blueColor
                                  : Pallete.borderColor,
                              price: "300",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                price = 700;
                              });
                            },
                            child: CustomContainerWidget(
                              assetsName: "year",
                              title: "Annually",
                              color: price == 700
                                  ? Pallete.blueColor
                                  : Pallete.borderColor,
                              price: "700",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
