import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/OLX/screens/olx_cart_screen.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/kyc/screens/kyc_registration_screen.dart';
import 'package:eClassify/features/onboarding/screens/onboarding_screen.dart';
import 'package:eClassify/features/profile/screens/edit_profile_screen.dart';
import 'package:eClassify/features/shopping/screens/shopping_cart_screen.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user?.profilePic ?? ''),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    user?.email ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    user?.phoneNumber ?? "J",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ProfileScreenButtons(
                    title: "Edit Profile",
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) =>
                              EditProfilescreen(userModel: user!),
                        ),
                      );
                    },
                  ),
                  ProfileScreenButtons(
                    title: "Update KYC",
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => KYCRegistrationScreen(
                            user: user!,
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileScreenButtons(
                    title: "Logout",
                    textColor: Pallete.redColor,
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "General",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("My saved cart"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const ShoppingCartScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("My saved olx"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const OLXCartScreen(),
                        ),
                      );
                    },
                  ),
                  const ListTile(
                    title: Text("Country"),
                    trailing: Text("India"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreenButtons extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;

  const ProfileScreenButtons({
    super.key,
    required this.title,
    required this.onPressed,
    this.textColor = Pallete.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.whiteColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Pallete.borderColor),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
