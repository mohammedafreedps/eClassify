import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/profile/repository/profile_repository.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  return ProfileController(ref.watch(profileRepositoryProvider));
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository profileRepository;
  ProfileController(
    this.profileRepository,
  ) : super(false);

  void updateUser({
    required String docId,
    required String? name,
    required XFile? profilePic,
    required WidgetRef ref,
    required BuildContext context,
    required String userPincode,
    required String address,
  }) async {
    state = true;
    final res = await profileRepository.updateUser(
      docId: docId,
      name: name,
      profilePic: profilePic,
      ref: ref,
      userPincode: userPincode,
      address: address,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.toString()),
      (r) => Navigator.of(context).pop(),
    );
  }

  void updateUserNameOnly({
    required String docId,
    required String? name,
    required WidgetRef ref,
    required BuildContext context,
    required String userPincode,
    required String address,
  }) async {
    state = true;
    final res = await profileRepository.updateUserNameOnly(
      docId: docId,
      name: name,
      ref: ref,
      userPincode: userPincode,
      address: address,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.toString()),
      (r) => Navigator.of(context).pop(),
    );
  }
}
