import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/font_family.dart';
import 'package:eClassify/pay/Screens/TransferSuccessfullScreen/transfer_successfull_screen.dart';
import 'package:eClassify/pay/Utils/common_button_widget.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class EnterPinScreen extends StatelessWidget {
  EnterPinScreen({Key? key}) : super(key: key);

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
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "Confirm Payment",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            CommonTextWidget.InterBold(
              text: "Enter Your PIN",
              fontSize: 28,
              color: black171,
            ),
            CommonTextWidget.InterRegular(
              text: "Please enter your  PIN to confirm payment",
              fontSize: 12,
              color: grey757,
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                color: whiteF9F,
                child: PinPut(
                  fieldsCount: 4,
                  textStyle: TextStyle(
                    fontFamily: FontFamily.InterSemiBold,
                    fontSize: 24,
                    color: black171,
                  ),
                  cursorColor: black171,
                  eachFieldHeight: 55,
                  eachFieldWidth: 55,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: _pinPutDecoration.copyWith(
                    color: whiteF9F,
                    border: Border.all(
                      color: blue613,
                    ),
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
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: CommonButtonWidget.button(
                text: "Confirm Payment",
                buttonColor: blue613,
                onTap: () {
                  Get.to(() => TransferSuccessfullScreen());
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
