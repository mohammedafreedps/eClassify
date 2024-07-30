import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/error_text.dart';
import '../../../../../core/error/loader.dart';
import '../../../controller/jobs_controller.dart';
import 'job_feed_screen.dart';


class SavedJobScreen extends ConsumerWidget {
  const SavedJobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Saved Jobs'),
      ),
      body: ref.watch(getAllJobCartItemsProvider).when(
            data: (data) {
              return data.isEmpty
                  ? const Center(
                      child: Text("There are no saved jobs."),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final job = data[index];
                        return JobFeedDetailsWidget(job: job);
                      },
                    );
            },
            error: (error, st) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoadingScreen(),
          ),
    );
  }
}
