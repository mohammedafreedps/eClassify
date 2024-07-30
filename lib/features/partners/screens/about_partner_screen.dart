import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/partners/controller/partner_controller.dart';
import 'package:eClassify/features/partners/screens/partners_scheme_details_screen.dart';

class AboutPartnerScreen extends ConsumerStatefulWidget {
  const AboutPartnerScreen({super.key});

  @override
  ConsumerState<AboutPartnerScreen> createState() => _AboutPartnerScreenState();
}

class _AboutPartnerScreenState extends ConsumerState<AboutPartnerScreen> {
  late Razorpay _razorpay;
  int price = 0;
  String partnertitle = '';
  String priceInWords = '';
  late String selectedpartners;
  final List<String> partnerNames = const [
    'Business Partner',
    'Company Partner',
    'Channel Partner',
  ];

  @override
  void initState() {
    super.initState();
    selectedpartners = partnerNames[0];
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
    ref.watch(partnerControllerProvider.notifier).sendParterDetails(
          partnertitle: partnertitle,
          price: price,
          priceInWords: priceInWords,
          uid: ref.watch(userProvider)!.uid,
          context: context,
        );
    ref
        .watch(partnerControllerProvider.notifier)
        .updateUserPartner(context: context);
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    showSnackBar(context, "Fail to ${response.message}");
  }

  void handleExternalWallet(PaymentFailureResponse response) {}

  void sendPaymentToRazorPay({
    required String email,
    required int price,
  }) {
    setState(() {
      openCheckout(email: email, price: price);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Choose your plan",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: widgets.length,
                shrinkWrap: false,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = widgets[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          price = data.price;
                          priceInWords = data.planPrice;
                          partnertitle = data.title;
                        });
                        sendPaymentToRazorPay(
                          email: user.email,
                          price: data.price,
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Pallete.borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${data.planPrice} per Lifetime",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const PartnersSchemeDetailsScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Having a trobble?",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    " Get help here",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 90,
            //   child: ListView.builder(
            //     itemCount: widgets.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       final partners = partnerNames[index];
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 8.0,
            //         ),
            //         child: GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               selectedpartners = partners;
            //             });
            //           },
            //           child: Column(
            //             children: [
            //               Chip(
            //                 backgroundColor: selectedpartners == partners
            //                     ? Pallete.blueColor
            //                     : const Color.fromRGBO(245, 247, 249, 1),
            //                 side: const BorderSide(
            //                   color: Color.fromRGBO(245, 247, 249, 1),
            //                 ),
            //                 label: Text(partners),
            //                 labelStyle: const TextStyle(
            //                   fontSize: 16,
            //                 ),
            //                 padding: const EdgeInsets.symmetric(
            //                   horizontal: 20,
            //                   vertical: 15,
            //                 ),
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(30),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: widgets.length,
            //     itemBuilder: (context, index) {
            //       final partners = widgets[index];
            //       return Text(
            //         maxLines: null,
            //         partners.desc[index],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class AboutPartnerWidget {
  final String title;
  final String planPrice;
  final int price;
  String desc;

  AboutPartnerWidget({
    required this.title,
    required this.planPrice,
    required this.price,
    required this.desc,
  });
}

List<AboutPartnerWidget> widgets = [
  AboutPartnerWidget(
    title: "Business Partner",
    planPrice: "1 Lakh",
    price: 100000,
    desc:
        '1 Member for each positions.\n9 Members team. \nCleaner, Worker, IT Worker, Receptional Caller, Security, Advocate, Financial Advisor, Ad panel editor, Management Manager. \nMinimum one lakh security deposit to lifetime access.\nIn the total revenue total 30% of revenue goes to world wide web.',
  ),
  AboutPartnerWidget(
    title: "Company Partner",
    planPrice: "1 Lakh",
    price: 100000,
    desc:
        'Member for each positions. \n81 Members team. \nCleaner, Worker, IT Worker, Receptional Caller, Security, Advocate, Financial Advisor, Ad panel editor, Management Manager.\nMinimun ten lakh security deposit to lifetime access. \nIn the total revenue total 20% of revenue goes to world wide web.',
  ),
  AboutPartnerWidget(
    title: "Channel Partner",
    planPrice: "1 Lakh",
    price: 100000,
    desc:
        '10 Member for each positions. \n90-100 Members team. \nCleaner, Worker, IT Worker, Receptional Caller, Security, Advocate, Financial Advisor, Ad panel editor, Management Manager.\nMinimun one crore security deposit to lifetime access. \nIn the total revenue total 10% of revenue goes to world wide web.',
  ),
];
