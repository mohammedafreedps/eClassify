import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class CancelOrderDialog extends StatelessWidget {
  final Order order;
  final String orderItemId;

  const CancelOrderDialog({
    required this.order,
    required this.orderItemId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldReasonController = TextEditingController();
    return WillPopScope(
      onWillPop: () {
        if (context.read<UpdateOrderStatusProvider>().getUpdateOrderStatus() ==
            UpdateOrderStatus.inProgress) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: CustomTextLabel(
          jsonKey: "sure_to_cancel_order",
        ),
        content: TextField(
          controller: textFieldReasonController,
          autofocus: true,
          focusNode: FocusNode(),
          style: TextStyle(
            color: ColorsRes.mainTextColor,
          ),
        ),
        actions: [
          Consumer<UpdateOrderStatusProvider>(builder: (context, provider, _) {
            if (provider.getUpdateOrderStatus() ==
                UpdateOrderStatus.inProgress) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: CustomTextLabel(
                    jsonKey: "no",
                    style: TextStyle(color: ColorsRes.mainTextColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (textFieldReasonController.text.isNotEmpty) {
                      context
                          .read<UpdateOrderStatusProvider>()
                          .updateStatus(
                            order: order,
                            orderItemId: orderItemId,
                            status: Constant.orderStatusCode[6],
                            context: context,
                            reason: textFieldReasonController.text,
                          )
                          .then((value) {
                        Navigator.pop(context, value);
                      });
                    } else {
                      GeneralMethods.showMessage(
                          context,
                          getTranslatedValue(context, "reason_required"),
                          MessageType.warning);
                    }
                  },
                  child: CustomTextLabel(
                    jsonKey: "yes",
                    style: TextStyle(color: ColorsRes.appColor),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
