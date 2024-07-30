import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/onboarding/widgets/onboarding_button.dart';
import 'package:eClassify/features/partners/models/teams_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetailsScreen extends ConsumerWidget {
  final TeamsModel teamsModel;
  const PartnerDetailsScreen({
    required this.teamsModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Name: "),
                Text(teamsModel.name),
              ],
            ),
            Row(
              children: [
                const Text("Email: "),
                Text(teamsModel.email),
              ],
            ),
            Row(
              children: [
                const Text("Department: "),
                Text(teamsModel.department),
              ],
            ),
            Row(
              children: [
                const Text("Contact Number: "),
                Text(teamsModel.number.toString()),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OnboardingButtonWidget(
                  onPressed: () async {
                    Uri uri = Uri.parse('tel:+91${teamsModel.number}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                    // Uri phoneno = Uri.parse('tel:+91${teamsModel.number}');
                    // if (await launchUrl(phoneno)) {
                    //   openPhone(teamsModel.number.toString());
                    // } else {
                    //   showSnackBar(
                    //     context,
                    //     "Invaild Contact details",
                    //   );
                    // }
                  },
                  text: 'Call',
                  backgroungColor: Pallete.greenColor.withOpacity(0.3),
                  textColor: Pallete.greenColor,
                ),
                OnboardingButtonWidget(
                  onPressed: () async {
                    Uri uri = Uri.parse('mailto:${teamsModel.email}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                  },
                  text: 'Email',
                  backgroungColor: Pallete.greenColor.withOpacity(0.3),
                  textColor: Pallete.greenColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
