import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;
  final Color color;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
    required this.color,
  });
}

List<OnboardingContents> onboardingContents = [
  OnboardingContents(
    title: "Find jobs from the most popular job listing sites",
    image: "assets/onboarding/job2.png",
    desc: "Track all your job applicatons, Start appliying and get a Job Now!",
    color: const Color(0xfff5c435),
  ),
  OnboardingContents(
    title: "Order groceries and Great deals everyday",
    image: "assets/onboarding/Grocery shopping-cuate.png",
    desc: "Remember to keep track of your recent orders.",
    color: const Color(0xff8bd7df),
  ),
  OnboardingContents(
    title: "Get latest news in your location",
    image: "assets/onboarding/Instant information-pana.png",
    desc: "Stay organized with team and Get notified when work happens.",
    color: const Color(0xfff2d0dd),
  ),
];

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}
