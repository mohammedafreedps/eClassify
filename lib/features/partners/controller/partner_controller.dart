import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/partners/models/partner_model.dart';
import 'package:eClassify/features/partners/models/teams_model.dart';
import 'package:eClassify/features/partners/repository/partner_repository.dart';

final partnerControllerProvider =
    StateNotifierProvider<PartnerController, bool>((ref) {
  return PartnerController(
    partnerRepository: ref.watch(partnerRepositoryProvider),
  );
});

final getAllTeamsProvider = StreamProvider.family((ref, String uid) {
  final controller = ref.watch(partnerControllerProvider.notifier);
  return controller.getAllTeams(uid: uid);
});

class PartnerController extends StateNotifier<bool> {
  final PartnerRepository partnerRepository;
  PartnerController({
    required this.partnerRepository,
  }) : super(false);

  void sendParterDetails({
    required String partnertitle,
    required int price,
    required String priceInWords,
    required BuildContext context,
    required String uid,
  }) async {
    final res = await partnerRepository.sendParterDetails(
      partnertitle: partnertitle,
      price: price,
      priceInWords: priceInWords,
      uid: uid,
    );

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Future<PartnerModel> getCurrentPartnersData({
    required String docId,
  }) async {
    PartnerModel? user = await partnerRepository.getCurrentPartnersData(
      docId: docId,
    );
    return user;
  }

  void updateUserPartner({
    required BuildContext context,
  }) async {
    final res = await partnerRepository.updateUserPartner();

    res.fold((l) => showSnackBar(context, l.toString()), (r) => null);
  }

  void addTeams({
    required String name,
    required int number,
    required String email,
    required WidgetRef ref,
    required BuildContext context,
    required String department,
  }) async {
    final res = await partnerRepository.addTeams(
      name: name,
      number: number,
      email: email,
      ref: ref,
      department: department,
    );

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) => Navigator.of(context).pop(),
    );
  }

  Stream<List<TeamsModel>> getAllTeams({
    required String uid,
  }) {
    return partnerRepository.getAllTeams(uid: uid);
  }
}
