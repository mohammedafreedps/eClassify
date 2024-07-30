import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Screens/UserPaymentCodeScreens/my_qrcode_screen.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:eClassify/pay/Utils/lists_view.dart';
import 'package:eClassify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserPaymentCodeScreen extends StatelessWidget {
  UserPaymentCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyEDE,
      appBar: AppBar(
        backgroundColor: greyEDE,
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
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "John Doe",
                      fontSize: 26,
                    ),
                    SizedBox(height: 4),
                    CommonTextWidget.InterRegular(
                      color: black171,
                      text: "UPI ID: `1234567890@DigiWallet",
                      fontSize: 12,
                    ),
                    SizedBox(height: 6),
                    CommonTextWidget.InterRegular(
                      color: black171,
                      text: "DIgiwallet: 1234567890",
                      fontSize: 12,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => MyQrCodeScreen());
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey6B7.withOpacity(0.15),
                          offset: Offset(0, 0),
                          blurRadius: 25,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(Images.userQrCodeImage),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: whiteFBF,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(28),
                  topLeft: Radius.circular(28),
                ),
              ),
              child: Column(
                // alignment: Alignment.bottomCenter,
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                        itemCount: Lists.userQrCodeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 14),
                          child: InkWell(
                            onTap: Lists.userQrCodeList[index]["onTap"],
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.asset(
                                Lists.userQrCodeList[index]["image"],
                              ),
                              title: CommonTextWidget.InterBold(
                                color: black171,
                                text: Lists.userQrCodeList[index]["text1"],
                                fontSize: 14,
                              ),
                              subtitle: CommonTextWidget.InterRegular(
                                color: grey757,
                                text: Lists.userQrCodeList[index]["text2"],
                                fontSize: 12,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: grey757, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CommonTextWidget.InterRegular(
                        color: greyA6A,
                        text: "V 1.1.0",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
