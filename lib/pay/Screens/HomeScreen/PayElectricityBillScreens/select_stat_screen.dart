import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Utils/common_text_widget.dart';
import 'package:eClassify/pay/Utils/common_textfeild_widget.dart';
import 'package:eClassify/pay/Utils/lists_view.dart';
import 'package:eClassify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectStatScreen extends StatelessWidget {
  SelectStatScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: SvgPicture.asset(Images.information),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Select State",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField2(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: SvgPicture.asset(Images.search, color: blue613),
                  ),
                  keyboardType: TextInputType.text,
                  hintText: "Search State",
                  controller: searchController,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterMedium(
                      text: "My Current Location",
                      fontSize: 16,
                      color: blue613,
                    ),
                    Icon(Icons.location_on, color: blue613),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.selectYourCircle2List.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        // Get.to(() => SelectYourCircleScreen());
                      },
                      child: InkWell(
                        onTap: () {
                          // Get.to(() => PrepaidOperatorDetailScreen());
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: greyE5E, width: 1),
                            borderRadius: BorderRadius.circular(16),
                            color: white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CommonTextWidget.InterSemiBold(
                              text: Lists.selectYourCircle2List[index],
                              fontSize: 16,
                              color: black171,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
