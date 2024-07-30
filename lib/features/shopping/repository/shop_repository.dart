import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:eClassify/core/error/type_defs.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/shopping/models/shopping_items_model.dart';

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository(
    firestore: FirebaseFirestore.instance,
    ref: ref,
  );
});

class ShopRepository {
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  ShopRepository({
    required this.firestore,
    required this.ref,
  });

  FutureEither<void> saveShoppingCartToFirebase({
    required ShoppingCartItemsModel shoppingCartItemsModel,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      final res = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('shopCart')
          .doc(shoppingCartItemsModel.id)
          .set(shoppingCartItemsModel.toMap());

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<void> updateShoppingCartPaidToFirebase({
    required ShoppingCartItemsModel shoppingCartItemsModel,
  }) async {
    try {
      final user = ref.watch(userProvider)!;

      final res = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('shopCart')
          .doc(shoppingCartItemsModel.id)
          .update(
        {
          'isPaid': true,
        },
      );

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<void> saveShoppingToFirebaseForAdmin({
    required ShoppingCartItemsModel shoppingCartItemsModel,
  }) async {
    try {
      final res = await firestore
          .collection('Grocery_shopping')
          .doc(shoppingCartItemsModel.id)
          .set(shoppingCartItemsModel.toMap());

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<ShoppingCartItemsModel>> getAllShoppingCartItems() {
    final user = ref.watch(userProvider)!;

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('shopCart')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => ShoppingCartItemsModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  Future<void> delectShopCart({
    required String docId,
  }) async {
    final user = ref.watch(userProvider)!;
    return await firestore
        .collection('users')
        .doc(user.uid)
        .collection('shopCart')
        .doc(docId)
        .delete();
  }

  Future<void> deleteCollection(String collectionPath) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = ref.watch(userProvider)!;

      // Get a reference to the collection
      CollectionReference collectionRef = firestore
          .collection("users")
          .doc(user.uid)
          .collection(collectionPath);

      // Get all documents in the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Delete each document in the collection
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }

      // Delete the collection itself
      await collectionRef.doc().delete();

      print('Collection $collectionPath deleted successfully.');
    } catch (e) {
      print('Error deleting collection: $e');
    }
  }

  Future<void> delectAllShopCart() async {
    return await deleteCollection('shopCart');
  }

  Stream<List<OLXModel>> getOLXByName(String title) {
    return firestore
        .collection('olx')
        .where(
          "title",
          isLessThan: title.isEmpty
              ? null
              : title.substring(0, title.length - 1) +
                  String.fromCharCode(
                    title.codeUnitAt(title.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => OLXModel.fromMap(e.data()),
              )
              .toList(),
        );
  }
}
