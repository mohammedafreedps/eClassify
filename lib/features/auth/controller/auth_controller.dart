import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snack_bar.dart';

import '../../tabbar/tabbar_screen.dart';
import '../models/user_modelaaa.dart';
import '../repository/auth_repository.dart';



final userProvider = StateProvider<UserModelS?>((ref) => null);

final authControllerProvider =
StateNotifierProvider<AuthControllerNotifier, bool>((ref) {
  return AuthControllerNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  );
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getCurrentUserDataProvider = FutureProvider((ref) {
  return ref.watch(authControllerProvider.notifier).getCurrentUserDataaaa();
});

class AuthControllerNotifier extends StateNotifier<bool> {
  final AuthRepository authRepository;
  final Ref ref;

  AuthControllerNotifier({
    required this.authRepository,
    required this.ref,
  }) : super(false);

  void signiInWithGoogle(BuildContext context) async {
    state = true;
    final res = await authRepository.signInWithGoogle(context);

    res.fold(
          (l) => showSnackBar(context, l.error),
          (r) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const TabbarScreen(),
          ),
              (Route<dynamic> route) => false,
        );
        ref.watch(userProvider.notifier).update((state) => r);
      },
    );
    state = false;
  }

  Stream<User?> get authStateChange => authRepository.authStateChange;

  Future<UserModelS?> getCurrentUserDataaaa() async {
    UserModelS? user = await authRepository.getCurrentUserData();
    return user;
  }

  Future<void> signOut() async {
    state = true;
    await authRepository.signOut();
    state = false;
  }
}
