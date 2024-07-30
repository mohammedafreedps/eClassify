import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'dart:developer' as developer;

enum ProductState {
  initial,
  loaded,
  loading,
  loadingMore,
  empty,
  error,
}

class ProductListProvider extends ChangeNotifier {
  ProductState productState = ProductState.initial;
  String message = '';
  int currentSortByOrderIndex = 0;
  late ProductList productList;
  List<ProductListItem> products = [];
  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;

  getProductListProvider(
      {required Map<String, dynamic> params,
      required BuildContext context}) async {
    developer.log('getProductListProvider called with params: $params', name: 'ProductProvider');

    if (offset == 0) {
      productState = ProductState.loading;
    } else {
      productState = ProductState.loadingMore;
    }
    notifyListeners();

    params[ApiAndParams.limit] = Constant.defaultDataLoadLimitAtOnce.toString();
    params[ApiAndParams.offset] = offset.toString();

    try {
      developer.log('Calling getProductListApi with params: $params', name: 'ProductProvider');

      Map<String, dynamic> response =
          await getProductListApi(context: context, params: params);
      developer.log('Response from getProductListApi: $response', name: 'ProductProvider');

      if (response[ApiAndParams.status].toString() == "1") {
        productList = ProductList.fromJson(response);

        totalData = int.parse(productList.total);
        developer.log('Total data: $totalData', name: 'ProductProvider');
        if (totalData > 0) {
          products.addAll(productList.data);
          developer.log('Products loaded: ${products.length}', name: 'ProductProvider');

          hasMoreData = totalData > products.length;

          if (hasMoreData) {
            offset += Constant.defaultDataLoadLimitAtOnce;
          }
          productState = ProductState.loaded;
          notifyListeners();
        } else {
          productState = ProductState.empty;
          notifyListeners();
        }
      } else {
        message = Constant.somethingWentWrong;
        productState = ProductState.empty;
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      developer.log('Error in getProductListProvider: $message', name: 'ProductProvider', error: e);

      productState = ProductState.error;
      notifyListeners();
    }
  }
}
