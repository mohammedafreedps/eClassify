import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/pick_image.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/OLX/controller/olx_controller.dart';
import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';

class OLXUploadScreen extends ConsumerStatefulWidget {
  const OLXUploadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OLXUploadScreenState();
}

class _OLXUploadScreenState extends ConsumerState<OLXUploadScreen> {
  List<XFile?> images = [];
  final titleController = TextEditingController();
  final prizeController = TextEditingController();
  final detailsController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void uploadOlxToFirebase() {
    if (formKey.currentState!.validate()) {
      if (images.isNotEmpty) {
        ref.read(olxControllerProvider.notifier).uploadOLXToFirebase(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              prize: int.parse(prizeController.text.trim()),
              details: detailsController.text.trim(),
              imagePath: images,
              context: context,
            );
      } else {
        showSnackBar(context, "Please select product Images");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(olxControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX"),
        actions: [
          TextButton(
            onPressed: uploadOlxToFirebase,
            child: const Text("Upload"),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      images.isNotEmpty
                          ? CarouselSlider(
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.9,
                              ),
                              items: images.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(i!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                List<XFile> files = await pickMultipleImage();
                                setState(() {
                                  images = files;
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
                                      "Click here to select files",
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
                        title: "Product Title",
                        controller: titleController,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Product Prize",
                        controller: prizeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Product Details",
                        controller: detailsController,
                        maxLines: null,
                      ),
                      const SizedBox(height: 10),
                      InfoTextField(
                        title: "Product Descripton",
                        controller: descriptionController,
                        maxLines: null,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
