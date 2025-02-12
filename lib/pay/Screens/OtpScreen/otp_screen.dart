import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/font_family.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Screens/LinkBankAccountScreen/link_bankaccount_screen.dart';
import 'package:eClassify/pay/Utils/common_button_widget.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(
        color: greyA6A,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: whiteF9F,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 75),
            child: CommonTextWidget.InterBold(
              color: black171,
              text: "We have sent a OTP to 12345 67890",
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: CommonTextWidget.InterRegular(
              color: grey757,
              text: "Please ensure that the sim is present in this device",
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          SvgPicture.asset(Images.otpImage),
          SizedBox(height: 70),
          CommonTextWidget.InterRegular(
            color: grey757,
            text: "One Time Password (OTP)",
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              color: whiteF9F,
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(
                  fontFamily: FontFamily.InterMedium,
                  fontSize: 24,
                  color: black171,
                ),
                cursorColor: black171,
                eachFieldHeight: 40,
                eachFieldWidth: 40,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  color: whiteF9F,
                ),
                selectedFieldDecoration: _pinPutDecoration.copyWith(
                  color: whiteF9F,
                ),
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  color: whiteF9F,
                ),
                disabledDecoration: _pinPutDecoration.copyWith(
                  color: whiteF9F,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Resend code in ",
              style: TextStyle(
                fontFamily: FontFamily.InterRegular,
                fontSize: 12,
                color: grey757,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "43 ",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.InterRegular,
                      color: blue613),
                ),
                TextSpan(
                  text: "second",
                  style: TextStyle(
                    fontFamily: FontFamily.InterRegular,
                    fontSize: 12,
                    color: grey757,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CommonButtonWidget.button(
              text: "Continue",
              onTap: () {
                Get.to(() => LinkBankAccountScreen());
              },
              buttonColor: blue613,
            ),
          ),
        ],
      ),
    );
  }
}
