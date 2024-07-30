import 'package:flutter/material.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../widgets/item_add_widget.dart';
import '../../../widgets/job_custom_button.dart';


class JobSeekerPreferencesScreen extends StatelessWidget {
  const JobSeekerPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What kind of jobs are you looking for?",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "What role do you want to see?",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ItemAddWidget(
                onPressed: () {},
                title: 'Add role title',
              ),
              const SizedBox(height: 10),
              Text(
                "Where do you wish to work?",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ItemAddWidget(
                onPressed: () {},
                title: 'Add location',
              ),
              const SizedBox(height: 10),
              Text(
                "What type of job fit you better?",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ItemAddWidget(
                onPressed: () {},
                title: 'Add type',
              ),
              const SizedBox(height: 10),
              Text(
                "What is your salary range?",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              RangeSlider(
                values: const RangeValues(0, 1),
                labels: const RangeLabels("1LPA", "10LPA"),
                onChanged: (val) {},
                activeColor: Pallete.blueColor,
                inactiveColor: const Color(0xFF787880),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  JobCustomButton(
                    onpressed: () {},
                    text: "Cancel",
                    backgroundolor: const Color(0xFFF2F2F7),
                    textcolor: Pallete.blackColor,
                  ),
                  JobCustomButton(
                    onpressed: () {},
                    text: "OK",
                    backgroundolor: Pallete.blueColor,
                    textcolor: Pallete.whiteColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
