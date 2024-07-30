import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/components/get_user_location.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/core/utils/pick_image.dart';
import '../../auth/models/user_modelaaa.dart';
import 'package:eClassify/features/profile/controller/profile_controller.dart';

class EditProfilescreen extends ConsumerStatefulWidget {
  final UserModelS userModel;
  const EditProfilescreen({
    super.key,
    required this.userModel,
  });

  @override
  ConsumerState<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends ConsumerState<EditProfilescreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  XFile? image;
  String? userAddress;
  String? userPincode;
  Position? _currentPosition;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.userModel.name);
    emailController = TextEditingController(text: widget.userModel.email);
    phoneController = TextEditingController(text: widget.userModel.phoneNumber);
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await ref
        .watch(handleLocationPermissionProvider)
        .handleLocationPermission(context: context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint("vvvvvvvvvvvvvvvvvvv $e");
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        userAddress =
            '${place.street}, ${place.subLocality} ${place.subAdministrativeArea}, ${place.postalCode}';
        userPincode = place.postalCode;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.read(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Edit Profile',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (image != null) {
                ref.read(profileControllerProvider.notifier).updateUser(
                      docId: widget.userModel.uid,
                      name: nameController.text.trim(),
                      profilePic: image,
                      ref: ref,
                      context: context,
                      userPincode: userPincode!,
                      address: userAddress!,
                    );
              } else {
                ref.read(profileControllerProvider.notifier).updateUserNameOnly(
                      docId: widget.userModel.uid,
                      name: nameController.text.trim(),
                      ref: ref,
                      context: context,
                      userPincode: userPincode!,
                      address: userAddress!,
                    );
              }
            },
            child: const Text(
              'Save ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile file = await pickImage();
                      setState(() {
                        image = file;
                      });
                    },
                    child: image == null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.userModel.profilePic,
                            ),
                            radius: 40,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              File(image!.path),
                            ),
                            radius: 40,
                          ),
                  ),
                  const SizedBox(height: 14),
                  ProfileTextFeild(
                    controller: nameController,
                    labelText: 'Name *',
                  ),
                  ProfileTextFeild(
                    controller: emailController,
                    labelText: 'Email *',
                  ),
                  ProfileTextFeild(
                    controller: phoneController,
                    labelText: 'Phone Number *',
                  ),
                  GestureDetector(
                    onTap: () {
                      _getCurrentPosition();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Pallete.blackColor))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.userModel.address!.isNotEmpty
                                ? Text(widget.userModel.address!)
                                : Text(
                                    userAddress ?? "Tap Here to add location",
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ProfileTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const ProfileTextFeild({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
