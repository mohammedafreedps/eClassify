import 'package:carousel_slider/carousel_slider.dart';
import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Controllers/banner_controller.dart';
import 'package:eClassify/pay/Screens/HomeScreen/to_bank_account_screen.dart';
import 'package:eClassify/pay/Screens/HomeScreen/to_mobile_screen.dart';
import 'package:eClassify/pay/Screens/HomeScreen/to_self_screen.dart';
import 'package:eClassify/pay/Screens/ScannerScreen/scanner_screen.dart';
import 'package:eClassify/pay/Screens/SearchScreen/search_screen.dart';
import 'package:eClassify/pay/Screens/UserPaymentCodeScreens/user_payment_code_screen.dart';
import 'package:eClassify/pay/Utils/common_grid_widget_view.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:eClassify/pay/Utils/lists_view.dart';
import 'package:eClassify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreenPay extends StatelessWidget {
  HomeScreenPay({Key? key}) : super(key: key);

  final BannerSliderController bannerSliderController =
      Get.put(BannerSliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Stack(
        children: [
          Column(
            children: [
              /// TopContainer Widget View
              TopContainerWidgetView(),

              /// MyDigiWallet Widget View
              BodyWidgetView(context),
            ],
          ),

          /// TopContainer2 Widget View
          TopContainer2WidgetView(),

          /// Bottom Image Widget View
          // BottomImageWidgetView(),
        ],
      ),
    );
  }

  /// TopContainer Widget View
  Widget TopContainerWidgetView() {
    return Container(
      height: 190,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.homeTopBgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: ListTile(
          horizontalTitleGap: 0,
          leading: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: Image.asset(Images.homeTopProfileImage),
          ),
          title: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: CommonTextWidget.InterMedium(
              color: black171,
              text: "Good Morning,",
              fontSize: 12,
            ),
          ),
          subtitle: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: CommonTextWidget.InterBold(
              color: black171,
              text: "Hello John Doe",
              fontSize: 20,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ScannerScreen());
                },
                child: SvgPicture.asset(Images.scanCodeIcon),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Get.to(() => SearchScreen());
                },
                child: SvgPicture.asset(Images.search),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// TopContainer2 Widget View
  Widget TopContainer2WidgetView() {
    return Positioned(
      top: 145,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: blue613.withOpacity(0.22),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ScannerScreen());
                },
                child: Column(
                  children: [
                    SvgPicture.asset(Images.scanAndPay),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "Scan & Pay",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ToMobileScreen());
                },
                child: Column(
                  children: [
                    SvgPicture.asset(Images.toMobile),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "To Mobile",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ToSelfScreen());
                },
                child: Column(
                  children: [
                    SvgPicture.asset(Images.toSelf),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "To Self",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ToBankAccountScreen());
                },
                child: Column(
                  children: [
                    SvgPicture.asset(Images.bank),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "To Bank A/C",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Body Widget View
  Widget BodyWidgetView(context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              /// MyDigiWallet Widget View
             /* Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "Your UPI ",
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterRegular(
                      color: grey757,
                      text: "UPI ID: 1234567890@paytm",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),*/
              /*CommonGridWidget.grid(
                context,
                Lists.myDigiWalletList,
                () {},
              ),*/

             // SizedBox(height: 10),

              /// banner1 Widget View
            //  Banner1WidgetView(),
              SizedBox(height: 20),
              /// Recharge&BillPayments Widget View
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "Recharge & Bill Payments",
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterBold(
                      color: blue613,
                      text: "View All",
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              CommonGridWidget.grid(
                context,
                Lists.rechargeAndBillPaymentsList,
                () {},
              ),

              SizedBox(height: 20),

              Divider(thickness: 1, color: greyE7E),

            /*  SizedBox(height: 15),

              /// LoanAndCreditCard Widget View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterBold(
                  color: black171,
                  text: "Loan & Credit Cards",
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterRegular(
                  color: grey6A7,
                  text: "Instant Approvals",
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              CommonGridWidget.grid(
                context,
                Lists.loanAndCreditCardList,
                () {},
              ),
              SizedBox(height: 20),

              Divider(thickness: 1, color: greyE7E),

              SizedBox(height: 15),

              /// TicketBooking Widget View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterBold(
                  color: black171,
                  text: "Ticket Booking",
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 15),
              CommonGridWidget.grid(
                context,
                Lists.ticketBookingList,
                () {},
              ),

              SizedBox(height: 20),

              /// Banner2 Widget View
              Container(
                height: 80,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.banner2Image1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 15),

              /// TicketBooking Widget View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterBold(
                  color: black171,
                  text: "Invest & Trade in Stocks",
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 15),
              CommonGridWidget.grid(
                context,
                Lists.investAndTradStockList,
                () {},
              ),

              SizedBox(height: 20),

              Divider(thickness: 1, color: greyE7E),

              /// Insurance Widget View
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "Insurance",
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterBold(
                      color: blue613,
                      text: "View All",
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              CommonGridWidget.grid(
                context,
                Lists.insuranceList,
                () {},
              ),
              SizedBox(height: 20),

              Divider(thickness: 1, color: greyE7E),

              SizedBox(height: 15),

              /// FirstGamesByDigiWallet Widget View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterBold(
                  color: black171,
                  text: "First Games by DigiWallet",
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterRegular(
                  color: grey6A7,
                  text: "Play & Win",
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 12),
              CommonGridWidget.grid1(
                context,
                Lists.firstGamesByDigiWalletList,
                () {},
              ),
              SizedBox(height: 20),

              /// Banner3 Widget View
              Container(
                height: 170,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.banner3Image1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CommonTextWidget.InterBold(
                  color: black171,
                  text: "Recommended",
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: whiteFDF,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Images.recommendedImage1,
                                  height: 45, width: 45),
                              SizedBox(height: 8),
                              CommonTextWidget.InterMedium(
                                color: black171,
                                text: "Payein ₹3 Lakh "
                                    "tak Loan. Pepay "
                                    "in easy EMIs",
                                fontSize: 10,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 140,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: whiteFDF,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Images.recommendedImage2,
                                  height: 45, width: 45),
                              SizedBox(height: 8),
                              CommonTextWidget.InterMedium(
                                color: black171,
                                text: "Refer & Earn :) "
                                    "Get ₹100 "
                                    "Cashback",
                                fontSize: 10,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 140,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: whiteFDF,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Images.recommendedImage3,
                                  height: 45, width: 45),
                              SizedBox(height: 8),
                              CommonTextWidget.InterMedium(
                                color: black171,
                                text: "Get ₹600 "
                                    "Cashback on "
                                    "Rent Payment",
                                fontSize: 10,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "Discover with DigiWallet",
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterBold(
                      color: blue613,
                      text: "View All",
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              CommonGridWidget.grid2(
                context,
                Lists.discoverWithDigiWallet,
                () {},
              ),

              /// DigiWalletHealth Widget View
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "DigiWallet Health",
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterBold(
                      color: blue613,
                      text: "View All",
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              CommonGridWidget.grid(
                context,
                Lists.digiWalletHealthList,
                () {},
              ),

              /// List Widget View
              ListWidgetView(),
              SizedBox(height: 60),

              /// Bottom Widget View
              BottomWidgetView(),
              SizedBox(height: 60),*/
            ],
          ),
        ),
      ),
    );
  }

  /// banner1 Widget View
  Widget Banner1WidgetView() {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: Lists.banner1List.length,
          itemBuilder: (BuildContext context, index, int pageViewIndex) =>
              Container(
            height: 125,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Lists.banner1List[index]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              initialPage: 3,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                bannerSliderController.banner1.value = index;
              }),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.only(top: 170),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < Lists.banner1List.length; i++)
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                          height: 6,
                          width: i == bannerSliderController.banner1.value
                              ? 16
                              : 6,
                          decoration: BoxDecoration(
                              color: i == bannerSliderController.banner1.value
                                  ? blue613
                                  : black.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(9))),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// List Widget View
  Widget ListWidgetView() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 25, right: 25, top: 20),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Lists.listViewList.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: greyE7E, width: 1),
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Lists.listViewList[index]["image"],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterSemiBold(
                        color: black171,
                        fontSize: 14,
                        text: Lists.listViewList[index]["text1"],
                      ),
                      SizedBox(height: 3),
                      CommonTextWidget.InterRegular(
                        color: grey6A7,
                        fontSize: 10,
                        text: Lists.listViewList[index]["text2"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom Widget View
  Widget BottomWidgetView() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget.InterBold(
            color: black171,
            fontSize: 15,
            text: "Invite your friends",
          ),
          SizedBox(height: 10),
          CommonTextWidget.InterRegular(
            color: black171,
            fontSize: 13,
            text: "Get \$51 after each friends first payment",
          ),
          SizedBox(height: 25),
          MaterialButton(
            onPressed: () {},
            height: 30,
            minWidth: 65,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: green21E.withOpacity(0.29),
            child: CommonTextWidget.InterSemiBold(
              fontSize: 16,
              text: "Invite",
              color: white,
            ),
          )
        ],
      ),
    );
  }

  /// Bottom Image Widget View
  Widget BottomImageWidgetView() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Image.asset(Images.homeBottomImage),
      // Container(
      //   height: 400,
      //   width: Get.width,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(Images.homeBottomImage),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
    );
  }
}
