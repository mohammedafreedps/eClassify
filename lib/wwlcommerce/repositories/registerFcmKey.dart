import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

Future registerFcmKey(
    {required BuildContext context, required String fcmToken}) async {

  await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiAddFcmToken,
    params: {ApiAndParams.fcmToken: fcmToken},
    isPost: true,
    context: context,
  );
}

Future updateFcmKey(
    {required BuildContext context, required String fcmToken}) async {

  await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiUpdateFcmToken,
    params: {ApiAndParams.fcmToken: fcmToken},
    isPost: true,
    context: context,
  );
}
