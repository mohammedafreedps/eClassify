import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/home/home_screen.dart';
import 'package:eClassify/features/news/screens/news_feed_for_tab_screen.dart';
import 'package:eClassify/features/news/screens/pincode_news_screen.dart';
import 'package:eClassify/features/news/screens/sports_news_screen.dart';
import 'package:eClassify/features/partners/drawers/partner_drawer.dart';
import 'package:eClassify/features/profile/screens/profile_screen.dart';

class TabbarScreen extends ConsumerStatefulWidget {
  final bool isCompleted;
  const TabbarScreen({
    super.key,
    this.isCompleted = false,
  });

  @override
  ConsumerState<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends ConsumerState<TabbarScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  int currentIndex = 0;

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: currentIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text("World Work Links"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bell),
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorWeight: 4,
            unselectedLabelColor: Pallete.greyColor.withOpacity(0.5),
            labelColor: Pallete.blackColor,
            indicatorColor: Pallete.blackColor,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            tabs: const [
              Tab(
                icon: Icon(CupertinoIcons.house_fill),
              ),
              // Tab(
              //   icon: Icon(CupertinoIcons.play_rectangle_fill),
              // ),
              Tab(
                icon: Icon(Icons.sports_baseball_outlined),
              ),
              Tab(
                icon: Icon(CupertinoIcons.news_solid),
              ),
              Tab(
                icon: Icon(CupertinoIcons.location_fill),
              ),
              Tab(
                icon: Icon(CupertinoIcons.person_crop_circle_fill),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            HomeScreen(),
            SportsNewsScreen(),
            NewsFeedForTabScreen(),
            PincodeNewsScreen(),
            ProfileScreen(),
          ],
        ),
        drawer: const PartnerListDrawer(),
        bottomNavigationBar: widget.isCompleted
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Text("Uploading Video..."),
              )
            : null,
      ),
    );
  }
}
