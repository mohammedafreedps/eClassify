import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';
import 'package:eClassify/features/OLX/repository/olx_repository.dart';

final olxControllerProvider = StateNotifierProvider<OLXController, bool>((ref) {
  return OLXController(
    olxRepository: ref.watch(olxRepositoryProvider),
  );
});

final getAllOlxItemsProvider = StreamProvider((ref) {
  final controller = ref.watch(olxControllerProvider.notifier);
  return controller.getAllOlxItems();
});

final getAllOlxCartItemsProvider = StreamProvider((ref) {
  final controller = ref.watch(olxControllerProvider.notifier);
  return controller.getAllOlxCartItems();
});

final getOLXByNameProvider = StreamProvider.family((ref, String title) {
  final controller = ref.watch(olxControllerProvider.notifier);
  return controller.getOLXByName(title);
});

class OLXController extends StateNotifier<bool> {
  final OLXRepository olxRepository;
  OLXController({
    required this.olxRepository,
  }) : super(false);

  void uploadOLXToFirebase({
    required String title,
    required String description,
    required int prize,
    required String details,
    required List<XFile?> imagePath,
    required BuildContext context,
  }) async {
    state = true;
    final res = await olxRepository.uploadOLXToFirebase(
      title: title,
      description: description,
      prize: prize,
      details: details,
      imagePath: imagePath,
    );
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<OLXModel>> getAllOlxItems() {
    return olxRepository.getAllOlxItems();
  }

  void saveOLXCartToFirebase({
    required OLXModel olxModel,
  }) async {
    state = true;
    final res = await olxRepository.saveOLXCartToFirebase(
      olxModel: olxModel,
    );
    state = false;

    res.fold(
      (l) => null,
      (r) => null,
    );
  }

  Stream<List<OLXModel>> getAllOlxCartItems() {
    return olxRepository.getAllOlxCartItems();
  }

  Stream<List<OLXModel>> getOLXByName(String title) {
    return olxRepository.getOLXByName(title);
  }
}
