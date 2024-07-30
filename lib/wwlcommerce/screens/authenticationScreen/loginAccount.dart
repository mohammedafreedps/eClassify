import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class LoginAccount extends StatefulWidget {
  final String? from;

  const LoginAccount({Key? key, this.from}) : super(key: key);

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  CountryCode? selectedCountryCode;
  bool isLoading = false, isAcceptedTerms = false;
  TextEditingController edtPhoneNumber = TextEditingController();
  bool isDark = Constant.session.getBoolData(SessionManager.isDarkTheme);
  String otpVerificationId = "";
  String phoneNumber = "";
  int? forceResendingToken;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    print("LoginAccount initState");
  }

  @override
  Widget build(BuildContext context) {
    print("Building LoginAccount UI");
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Constant.size10, vertical: Constant.size20),
              child: Container(
                constraints: BoxConstraints(maxHeight: context.width * 0.5),
                child: Widgets.defaultImg(
                  image: "logo",
                ),
              ),
            ),
            Card(
              color: Theme.of(context).cardColor,
              surfaceTintColor: Theme.of(context).cardColor,
              shape: DesignConfig.setRoundedBorderSpecific(10,
                  istop: true, isbtm: true),
              margin: EdgeInsets.symmetric(
                  horizontal: Constant.size5, vertical: Constant.size5),
              child: loginWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  proceedBtn() {
    print("Building proceedBtn");
    return isLoading
        ? Container(
      height: 55,
      alignment: AlignmentDirectional.center,
      child: CircularProgressIndicator(),
    )
        : Widgets.gradientBtnWidget(context, 10,
        title: getTranslatedValue(
          context,
          "login",
        ).toUpperCase(), callback: () {
          print("Proceed button tapped");
          loginWithPhoneNumber();
        });
  }

  skipLoginText() {
    print("Building skipLoginText");
    return GestureDetector(
      onTap: () async {
        print("Skip login text tapped");
        if (isLoading == false) {
          Constant.session
              .setBoolData(SessionManager.keySkipLogin, true, false);
          await getRedirection();
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: CustomTextLabel(
          jsonKey: "skip_login",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isLoading == false ? ColorsRes.appColor : ColorsRes.grey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  loginWidgets() {
    print("Building loginWidgets");
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(
          vertical: Constant.size30, horizontal: Constant.size20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: CustomTextLabel(
            jsonKey: "welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontSize: 30,
              color: ColorsRes.mainTextColor,
            ),
          ),
          subtitle: CustomTextLabel(
            jsonKey: "login_enter_number_message",
            style: TextStyle(color: ColorsRes.grey),
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        Container(
            decoration: DesignConfig.boxDecoration(
                Theme.of(context).scaffoldBackgroundColor, 10),
            child: mobileNoWidget()),
        Widgets.getSizedBox(
          height: Constant.size15,
        ),
        Row(
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: isAcceptedTerms,
              activeColor: ColorsRes.appColor,
              onChanged: (bool? val) {
                setState(() {
                  isAcceptedTerms = val!;
                });
              },
            ),
            Expanded(
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorsRes.mainTextColor,
                    ),
                  ),
                  text: "${getTranslatedValue(
                    context,
                    "agreement_message_1",
                  )}\t",
                  children: <TextSpan>[
                    TextSpan(
                        text: context
                            .read<LanguageProvider>()
                            .currentLanguage["terms_of_service"] ??
                            "terms_of_service",
                        style: TextStyle(
                          color: ColorsRes.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, webViewScreen,
                                arguments: getTranslatedValue(
                                  context,
                                  "terms_and_conditions",
                                ));
                          }),
                    TextSpan(
                        text: "\t${getTranslatedValue(
                          context,
                          "and",
                        )}\t",
                        style: TextStyle(
                          color: ColorsRes.mainTextColor,
                        )),
                    TextSpan(
                        text: context
                            .read<LanguageProvider>()
                            .currentLanguage["privacy_policy"] ??
                            "privacy_policy",
                        style: TextStyle(
                          color: ColorsRes.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, webViewScreen,
                                arguments: getTranslatedValue(
                                  context,
                                  "privacy_policy",
                                ));
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        proceedBtn(),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        skipLoginText(),
      ]),
    );
  }

  mobileNoWidget() {
    print("Building mobileNoWidget");
    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(
          Icons.phone_android,
          color: ColorsRes.mainTextColor,
        ),
        IgnorePointer(
          ignoring: isLoading,
          child: CountryCodePicker(
            onInit: (countryCode) {
              selectedCountryCode = countryCode;
            },
            onChanged: (countryCode) {
              selectedCountryCode = countryCode;
            },
            initialSelection: Constant.initialCountryCode,
            textOverflow: TextOverflow.ellipsis,
            showCountryOnly: false,
            alignLeft: false,
            backgroundColor: Theme.of(context).cardColor,
            textStyle: TextStyle(color: ColorsRes.mainTextColor),
            dialogBackgroundColor: Theme.of(context).cardColor,
            dialogSize: Size(context.width, context.height * 0.9),
            padding: EdgeInsets.zero,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: ColorsRes.grey,
          size: 15,
        ),
        Widgets.getSizedBox(
          width: Constant.size10,
        ),
        Flexible(
          child: TextField(
            controller: edtPhoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            style: TextStyle(
              color: ColorsRes.mainTextColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey[300]),
              hintText: "9999999999",
            ),
          ),
        )
      ],
    );
  }

  getRedirection() async {
    print("Executing getRedirection");
    if (Constant.session.getBoolData(SessionManager.keySkipLogin) ||
        Constant.session.getBoolData(SessionManager.isUserLogin)) {
      if ((Constant.session.getData(SessionManager.keyLatitude) == "" &&
          Constant.session.getData(SessionManager.keyLongitude) == "") ||
          (Constant.session.getData(SessionManager.keyLatitude) == "0" &&
              Constant.session.getData(SessionManager.keyLongitude) == "0")) {
        Navigator.pushReplacementNamed(context, confirmLocationScreeneCom,
            arguments: [null, "location"]);
      } else if (Constant.session
          .getData(SessionManager.keyUserName)
          .isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          mainHomeScreen,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          mainHomeScreen,
              (route) => false,
        );
      }
    }
  }

  Future<bool> mobileNumberValidation() async {
    print("Executing mobileNumberValidation");
    bool checkInternet = true; //await GeneralMethods.checkInternet();
    String? mobileValidate = await GeneralMethods.phoneValidation(
      edtPhoneNumber.text,
    );
    if (!checkInternet) {
      GeneralMethods.showMessage(
        context,
        getTranslatedValue(
          context,
          "check_internet",
        ),
        MessageType.warning,
      );
      return false;
    } else if (mobileValidate == "") {
      GeneralMethods.showMessage(
        context,
        getTranslatedValue(
          context,
          "enter_valid_mobile",
        ),
        MessageType.warning,
      );
      return false;
    } else if (mobileValidate != null && edtPhoneNumber.text.length > 15) {
      GeneralMethods.showMessage(
        context,
        getTranslatedValue(
          context,
          "enter_valid_mobile",
        ),
        MessageType.warning,
      );
      return false;
    } else if (!isAcceptedTerms) {
      GeneralMethods.showMessage(
        context,
        getTranslatedValue(
          context,
          "accept_terms_and_condition",
        ),
        MessageType.warning,
      );

      return false;
    } else {
      return true;
    }
  }

  loginWithPhoneNumber() async {
    print("Executing loginWithPhoneNumber");
    var validation = await mobileNumberValidation();
    if (validation) {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });
      firebaseLoginProcess();
    }
  }

  firebaseLoginProcess() async {
    print("Executing firebaseLoginProcess");
    if (edtPhoneNumber.text.isNotEmpty) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: Constant.otpTimeOutSecond),
        phoneNumber: '${selectedCountryCode!.dialCode}${edtPhoneNumber.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          GeneralMethods.showMessage(
            context,
            e.message!,
            MessageType.warning,
          );

          setState(() {
            isLoading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          forceResendingToken = resendToken;
          isLoading = false;
          setState(() {
            phoneNumber =
            '${selectedCountryCode!.dialCode} - ${edtPhoneNumber.text}';
            otpVerificationId = verificationId;

            List<dynamic> firebaseArguments = [
              firebaseAuth,
              otpVerificationId,
              edtPhoneNumber.text,
              selectedCountryCode!,
              widget.from ?? null
            ];
            Navigator.pushNamed(context, otpScreen,
                arguments: firebaseArguments);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        forceResendingToken: forceResendingToken,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("LoginAccount disposed");
  }
}
