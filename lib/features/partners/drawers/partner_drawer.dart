import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/error/error_text.dart';
import 'package:eClassify/core/error/loader.dart';
import 'package:eClassify/features/auth/controller/auth_controller.dart';
import 'package:eClassify/features/partners/controller/partner_controller.dart';
import 'package:eClassify/features/partners/screens/about_partner_screen.dart';
import 'package:eClassify/features/partners/screens/add_team_screen.dart';
import 'package:eClassify/features/partners/screens/partner_details_screen.dart';

class PartnerListDrawer extends ConsumerWidget {
  const PartnerListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {}

  void navigateToCommunity(
    BuildContext context,
  ) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.isPartner
                ? ListTile(
                    title: const Text("Add Your Team"),
                    leading: const Icon(Icons.add),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const AddTeamScreen(),
                        ),
                      );
                    },
                  )
                : ListTile(
                    title: const Text("Become a partner"),
                    leading: const Icon(Icons.add),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const AboutPartnerScreen(),
                        ),
                      );
                    },
                  ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "My Teams",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ref.watch(getAllTeamsProvider(user.uid)).when(
                  data: (data) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          final team = data[index];

                          return ListTile(
                            title: Text(team.name),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => PartnerDetailsScreen(
                                    teamsModel: team,
                                  ),
                                ),
                              );
                            },
                            subtitle: Text(team.department),
                            trailing: Icon(Icons.arrow_forward_ios),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, st) {
                    return ErrorScreen(
                      error: error.toString(),
                    );
                  },
                  loading: () => const LoadingScreen(),
                )
          ],
        ),
      ),
    );
  }
}
