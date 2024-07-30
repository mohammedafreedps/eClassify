import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../features/OLX/controller/olx_controller.dart';
import '../../features/OLX/screens/olx_cart_screen.dart';
import '../../features/OLX/screens/olx_details_screen.dart';
import '../error/error_text.dart';
import '../error/loader.dart';



class OLXSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  OLXSearchDelegate({
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
    return ref.watch(getOLXByNameProvider(query)).when(
          data: (data) {
            return data.isEmpty
                ? Center(child: Text("There are no items with $query"))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final olx = data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        OLXDetailsScreen(olxModel: olx),
                                  ),
                                );
                              },
                              child: OLXCartCard(cart: olx)),
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
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(getOLXByNameProvider(query)).when(
          data: (data) {
            return data.isEmpty
                ? const Center(child: Text("Search olx with Title"))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final olx = data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        OLXDetailsScreen(olxModel: olx),
                                  ),
                                );
                              },
                              child: OLXCartCard(cart: olx)),
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
        );
  }
}
