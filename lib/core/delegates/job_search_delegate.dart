import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../features/jobs/controller/jobs_controller.dart';
import '../../features/jobs/screens/job_seeker/screens/job_feed_screen.dart';
import '../error/error_text.dart';
import '../error/loader.dart';



class JobSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  JobSearchDelegate({
    required this.ref,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
              },
            )
          : const Text(""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ref.watch(getJobsByNameProvider(query)).when(
          data: (data) {
            return data.isEmpty
                ? Center(child: Text("There are no jobs with $query"))
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
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(getJobsByNameProvider(query)).when(
          data: (data) {
            return data.isEmpty
                ? const Center(child: Text("Search jobs with job Title"))
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
        );
  }
}
