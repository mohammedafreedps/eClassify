import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/pick_image.dart';
import 'package:eClassify/core/utils/show_dialogue.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
import 'package:eClassify/features/news/controller/news_controller.dart';
import 'package:eClassify/features/profile/screens/edit_profile_screen.dart';

class AddNewsScreen extends ConsumerStatefulWidget {
  const AddNewsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNewsScreen();
}

class _AddNewsScreen extends ConsumerState<AddNewsScreen> {
  bool isSport = false;
  final newsTitleController = TextEditingController();
  final newsDescController = TextEditingController();
  XFile? image;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(newsControllerProvider);
    final user = ref.watch(userProvider)!;
    print('address: $user.address');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate() && image != null) {
                print('address: $user.address');
                if (user.address!.isNotEmpty) {
                  ref
                      .watch(newsControllerProvider.notifier)
                      .uploadNewsToFirebase(
                        title: newsTitleController.text.trim(),
                        file: image!,
                        description: newsDescController.text.trim(),
                        context: context,
                        userAddress: user.address!,
                        userPincode: user.userPincode!,
                        isSports: isSport,
                      );
                } else {
                  showAdaptiveDialogs(
                    context,
                    () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) =>
                              EditProfilescreen(userModel: user),
                        ),
                      );
                    },
                  );
                }
              } else {
                showSnackBar(
                  context,
                  "Please select a tumbnail for the news",
                );
              }
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.sports_baseball_outlined,
                                color: Pallete.icongreyColor,
                              ),
                              Text(
                                "This is sports news",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Pallete.icongreyColor),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: isSport,
                            activeColor: Pallete.blueColor,
                            onChanged: (val) {
                              setState(() {
                                isSport = val;
                              });
                            },
                          ),
                        ],
                      ),
                      InfoTextField(
                        controller: newsTitleController,
                        title: "Add Title",
                      ),
                      const SizedBox(height: 15),
                      InfoTextField(
                        controller: newsDescController,
                        title: "Add Description",
                        maxLines: null,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
