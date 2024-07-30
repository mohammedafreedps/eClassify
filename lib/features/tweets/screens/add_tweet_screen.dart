import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/pick_image.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/tweets/controller/tweet_controller.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final TextEditingController postController = TextEditingController();
  XFile? image;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(tweetControllerProvider);
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Tweet'),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate() && image != null) {
                ref.read(tweetControllerProvider.notifier).shareTweets(
                      text: postController.text.trim(),
                      context: context,
                      file: image!,
                    );
              } else {
                showSnackBar(
                  context,
                  "Please select a post image",
                );
              }
            },
            child: const Text('Post'),
          )
        ],
      ),
      body: isLoading
          ? const LoadingScreen()
          : Padding(
              padding: const EdgeInsets.all(8.0),
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
                                      .copyWith(color: Pallete.icongreyColor),
                                )
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 1),
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: postController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "tweet description is missing!";
                                  }
                                  return null;
                                },
                                maxLines: null,
                                decoration: const InputDecoration(
                                  hintText: 'Start a thread...',
                                  label: Text("Start a new tweet"),
                                  hintStyle: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
