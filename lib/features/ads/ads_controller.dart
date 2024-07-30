import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/snack_bar.dart';
import 'ads_repository.dart';


final adsControllerProvider = StateNotifierProvider<AdsController, bool>((ref) {
  return AdsController(adsRepository: ref.watch(adsRepositoryProvider));
});

class AdsController extends StateNotifier<bool> {
  final AdsRepository adsRepository;
  AdsController({
    required this.adsRepository,
  }) : super(false);

  void sendAdsToFirebase({
    required String title,
    required String description,
    required int selectedPrice,
    required XFile file,
    required BuildContext context,
  }) async {
    state = true;
    final res = await adsRepository.saveShoppingCartToFirebase(
      title: title,
      description: description,
      selectedPrice: selectedPrice,
      file: file,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) {
        return Navigator.of(context).pop();
      },
    );
  }
}
