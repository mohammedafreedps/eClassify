import 'package:flutter/material.dart';
import 'package:eClassify/features/partners/screens/about_partner_screen.dart';

class PartnersSchemeDetailsScreen extends StatelessWidget {
  const PartnersSchemeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Benefis of becoming partners with us.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Divider(),
            Text(
              'Business Partner',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              maxLines: null,
              widgets[0].desc,
            ),
            SizedBox(height: 15),
            Text(
              'Company Partner',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              maxLines: null,
              widgets[1].desc,
            ),
            SizedBox(height: 15),
            Text(
              'Channel Partner',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              maxLines: null,
              widgets[2].desc,
            ),
          ],
        ),
      ),
    );
  }
}
