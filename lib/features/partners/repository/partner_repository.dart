import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:eClassify/core/error/server_exception.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/partners/models/partner_model.dart';
import 'package:eClassify/features/partners/models/teams_model.dart';
import 'package:uuid/uuid.dart';

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  return PartnerRepository(firestore: FirebaseFirestore.instance);
});

class PartnerRepository {
  final FirebaseFirestore firestore;

  PartnerRepository({required this.firestore});

  FutureEither<PartnerModel> sendParterDetails({
    required String partnertitle,
    required int price,
    required String priceInWords,
    required String uid,
  }) async {
    try {
      final id = const Uuid().v1();
      final PartnerModel partnerModel = PartnerModel(
        partnertitle: partnertitle,
        dateCreated: DateTime.now(),
        price: price,
        id: id,
        priceInWords: priceInWords,
        uid: uid,
      );

      await firestore.collection("partners").doc(id).set(partnerModel.toMap());
      return right(partnerModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<PartnerModel> getCurrentPartnersData({
    required String docId,
  }) async {
    var userData = await firestore.collection('partners').doc(docId).get();

    PartnerModel? user;
    if (userData.data() != null) {
      user = PartnerModel.fromMap(userData.data()!);
    } else {
      throw ServerException("User Not found");
    }
    return user;
  }

  Future<Either<String, void>> updateUserPartner() async {
    try {
      final res = await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'isPartner': true,
      });

      return right(res);
    } catch (e) {
      return left(e.toString());
    }
  }

  FutureEither<TeamsModel> addTeams({
    required String name,
    required int number,
    required String email,
    required WidgetRef ref,
    required String department,
  }) async {
    try {
      final id = const Uuid().v1();
      final uid = ref.watch(userProvider)!.uid;

      final TeamsModel teamsModel = TeamsModel(
        name: name,
        email: email,
        dateCreated: DateTime.now(),
        number: number,
        id: id,
        department: department,
        uid: uid,
      );

      await firestore
          .collection("users")
          .doc(uid)
          .collection('Teams')
          .doc(id)
          .set(teamsModel.toMap());
      return right(teamsModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<TeamsModel>> getAllTeams({
    required String uid,
  }) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection("Teams")
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => TeamsModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
