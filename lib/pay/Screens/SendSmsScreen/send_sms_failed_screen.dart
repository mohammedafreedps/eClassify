import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Screens/OtpScreen/otp_screen.dart';
import 'package:eClassify/pay/Utils/common_button_widget.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:eClassify/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendSmsFailedScreen extends StatelessWidget {
  SendSmsFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 400),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: white,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: white,
              ),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 25, right: 25, bottom: 8),
                            child: CommonTextWidget.InterBold(
                              color: black171,
                              text: "Cancel",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(Images.faildSmsImage,
                          height: 120, width: 120),
                      Center(
                        child: CommonTextWidget.InterSemiBold(
                          color: black171,
                          text: "Failed to send SMS",
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: CommonTextWidget.InterRegular(
                          color: grey757,
                          text:
                              "it is important to have good phone network and "
                              "SMS balance to continue. if you have these "
                              "covered, please try again",
                          fontSize: 14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 35, bottom: 18, left: 25, right: 25),
                        child: CommonButtonWidget.button(
                          text: "Continue with OTP",
                          buttonColor: blue613,
                          onTap: () {
                            Get.to(() => OtpScreen());
                          },
                        ),
                      ),
                      CommonTextWidget.InterSemiBold(
                        color: blue613,
                        text: "Retry with SMS",
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
