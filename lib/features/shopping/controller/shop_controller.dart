import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/utils/snack_bar.dart';
import 'package:eClassify/features/OLX/model/olx_model.dart';
import 'package:eClassify/features/shopping/models/shopping_items_model.dart';
import 'package:eClassify/features/shopping/repository/shop_repository.dart';

final shopControllerProvider =
    StateNotifierProvider<ShopController, bool>((ref) {
  return ShopController(
    olxRepository: ref.watch(shopRepositoryProvider),
  );
});

final getAllShoppingCartItemsProvider = StreamProvider((ref) {
  final controller = ref.watch(shopControllerProvider.notifier);
  return controller.getAllShoppingCartItems();
});

class ShopController extends StateNotifier<bool> {
  final ShopRepository olxRepository;
  ShopController({
    required this.olxRepository,
  }) : super(false);

  void saveShoppingCartToFirebase({
    required ShoppingCartItemsModel shoppingCartItemsModel,
    required BuildContext context,
  }) async {
    state = true;
    final res = await olxRepository.saveShoppingCartToFirebase(
      shoppingCartItemsModel: shoppingCartItemsModel,
    );

    res.fold(
      (l) => showSnackBar(context, l.text),
      (r) {
        return showSnackBar(context, "Added to cart succesfully");
      },
    );
    state = false;
  }

  Future<void> delectAllShopCart() async {
    return await olxRepository.delectAllShopCart();
  }

  Future<void> delectShopCart({
    required String docId,
  }) async {
    return olxRepository.delectShopCart(docId: docId);
  }

  Stream<List<ShoppingCartItemsModel>> getAllShoppingCartItems() {
    return olxRepository.getAllShoppingCartItems();
  }

  Stream<List<OLXModel>> getOLXByName(String title) {
    return olxRepository.getOLXByName(title);
  }

  updateShoppingCartPaidToFirebase({
    required ShoppingCartItemsModel shoppingCartItemsModel,
  }) async {
    return await olxRepository.updateShoppingCartPaidToFirebase(
      shoppingCartItemsModel: shoppingCartItemsModel,
    );
  }
}
