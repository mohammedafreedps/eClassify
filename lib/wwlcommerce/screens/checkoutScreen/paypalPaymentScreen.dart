import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'package:flutter/cupertino.dart';

class PayPalPaymentScreen extends StatefulWidget {
  final String paymentUrl;

  const PayPalPaymentScreen({Key? key, required this.paymentUrl})
      : super(key: key);

  static Route route(RouteSettings settings) {
    Map arguments = settings.arguments as Map;
    return CupertinoPageRoute(builder: ((context) {
      return PayPalPaymentScreen(paymentUrl: arguments["paymentURL"]);
    }));
  }

  @override
  State<PayPalPaymentScreen> createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  WebViewController? webViewController;

  DateTime? currentBackPressTime;

  @override
  void initState() {
    print("URL is ${widget.paymentUrl}");
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      GeneralMethods.showMessage(
          context,
          getTranslatedValue(context,
              "do_not_press_back_while_payment_and_double_tap_back_button_to_exit"),
          MessageType.warning);
      return Future.value(false);
    }
    Navigator.pop(context, {"paymentStatus": "Failed"});
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: getAppBar(
            context: context,
            title: CustomTextLabel(
              jsonKey: "app_name",
              softWrap: true,
              style: TextStyle(color: ColorsRes.mainTextColor),
            ),
            showBackButton: true,
            onTap: onWillPop,
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(
                  Theme.of(context).colorScheme.primaryContainer)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith(Constant.baseUrl)) {
                      String redirectUrl = request.url.split("?")[0];
                      String paymentStatus = redirectUrl.split("/").last;
                      if (paymentStatus.toLowerCase() == "success") {
                        Navigator.pop(context, true);
                        return NavigationDecision.navigate;
                      } else if (paymentStatus.toLowerCase() == "fail") {
                        Navigator.pop(context, false);
                        return NavigationDecision.navigate;
                      }
                    }
                    return NavigationDecision.navigate;
                  },
                  onUrlChange: (request) {
                    if (request.url != null) {
                      if (request.url!.startsWith(Constant.baseUrl)) {
                        String redirectUrl = request.url!.split("?")[0];
                        String paymentStatus = redirectUrl.split("/").last;
                        if (paymentStatus.toLowerCase() == "success") {
                          Navigator.pop(context, true);
                        } else if (paymentStatus.toLowerCase() == "fail") {
                          Navigator.pop(context, false);
                        }
                      }
                    }
                  },
                ),
              )
              ..loadRequest(Uri.parse(widget.paymentUrl.toString())),
          ),
        ),
      ),
    );
  }
}
