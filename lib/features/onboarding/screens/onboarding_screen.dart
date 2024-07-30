import 'package:flutter/material.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/auth/screens/login_screen.dart';
import 'package:eClassify/features/onboarding/widgets/onboarding_button.dart';
import 'package:eClassify/features/onboarding/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage == index
            ? Pallete.blackColor
            : Colors.grey.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 25 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingContents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          onboardingContents[i].image,
                          // height: SizeConfig.blockV! * 10,
                          // width: width,
                        ),
                        // SizedBox(
                        //   height: SizeConfig.blockV! * 30,
                        // ),
                        SizedBox(height: (height >= 840) ? 30 : 15),
                        Text(
                          onboardingContents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          onboardingContents[i].desc,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingContents.length,
                        (int index) => _buildDots(
                          index: index,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OnboardingButtonWidget(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const LoginScreen())));
                          },
                          text: "Skip",
                          backgroungColor: Colors.green.withOpacity(0.2),
                          textColor: Colors.green,
                        ),
                        _currentPage + 1 == onboardingContents.length
                            ? OnboardingButtonWidget(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginScreen())));
                                },
                                text: "Continue",
                                backgroungColor: Pallete.greenColor,
                                textColor: Pallete.whiteColor,
                              )
                            : OnboardingButtonWidget(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                text: "Next",
                                backgroungColor: Pallete.greenColor,
                                textColor: Pallete.whiteColor,
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
