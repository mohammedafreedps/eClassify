import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getAddTransactionApi(
    {required BuildContext context,
    required Map<String, dynamic> params}) async {
  try {
    var response = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiAddTransaction,
        params: params,
        isPost: true,
        context: context);
    return json.decode(response);
  } catch (e) {
    rethrow;
  }
}
