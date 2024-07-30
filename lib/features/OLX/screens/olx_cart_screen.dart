import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/OLX/controller/olx_controller.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';
import 'package:eClassify/features/OLX/screens/olx_details_screen.dart';

class OLXCartScreen extends ConsumerStatefulWidget {
  const OLXCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OLXCartScreenState();
}

class _OLXCartScreenState extends ConsumerState<OLXCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Saved OLX",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ref.watch(getAllOlxCartItemsProvider).when(
            data: (data) {
              return data.isEmpty
                  ? const Center(
                      child: Text("There Are No Saved OLX."),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final olx = data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          OLXDetailsScreen(olxModel: olx),
                                    ),
                                  );
                                },
                                child: OLXCartCard(cart: olx)),
                          );
                        },
                      ),
                    );
            },
            error: (error, st) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoadingScreen(),
          ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        // height: 174,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Pallete.borderColor),
                        ),
                      ),
                      child: const Text(
                        "Check Out",
                        style: TextStyle(color: Pallete.blackColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OLXCartCard extends StatelessWidget {
  const OLXCartCard({
    super.key,
    required this.cart,
  });

  final OLXModel cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Image.network(
              cart.imagePath[0],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "₹${cart.prize}",
              ),
            )
          ],
        )
      ],
    );
  }
}

//  Dismissible(
//                         key: Key(index.toString()),
//                         direction: DismissDirection.endToStart,
//                         onDismissed: (direction) {
//                           // setState(() {
//                           //   demoCarts.removeAt(index);
//                           // });
//                         },
//                         // background: Container(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                         //   decoration: BoxDecoration(
//                         //     color: const Color(0xFFFFE6E6),
//                         //     borderRadius: BorderRadius.circular(15),
//                         //   ),
//                         //   child: Row(
//                         //     children: [
//                         //       const Spacer(),
//                         //       Image.network(olx.imagePath.first),
//                         //     ],
//                         //   ),
//                         // ),
//                         child:

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "337.15",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Pallete.borderColor),
                      ),
                    ),
                    child: const Text(
                      "Check Out",
                      style: TextStyle(color: Pallete.blackColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
