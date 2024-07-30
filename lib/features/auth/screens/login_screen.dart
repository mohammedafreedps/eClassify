import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/loader.dart';
import '../../../core/theme/pallete.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_icon_button.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Loader(),
                    SizedBox(height: 8),
                    Text("Logging in, Please wait"),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/onboarding/groceries-packages.png",
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Welcome",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Signup Now to get started",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        AuthIconButton(
                          onpressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .signiInWithGoogle(context);
                            setState(() {});
                          },
                          imagePath: "assets/icons/ig_google.png",
                          text: "Continue With Google",
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "By Continuing, you agree to our",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              " Terms and Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Pallete.blueColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
      ),
    );
  }
}
