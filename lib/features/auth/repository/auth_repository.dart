import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Utils/hive_Utils.dart';
import '../../../app/routes.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/server_exception.dart';

import '../../../data/cubits/auth/authentication_cubit.dart';
import '../../jobs/model/company_model.dart';
import '../../jobs/model/job_seeker_profile_model.dart';
import '../../kyc/model/kyc_model.dart';
import '../models/user_modelaaa.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<Either<Failure, UserModelS>> signInWithGoogle(
      BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final result = await auth.signInWithCredential(credential);
      print(result.toString() + '---------');
      UserModelS UserModel = await _handleUserCreationOrUpdate1(
          result.user!, result.additionalUserInfo!.isNewUser);

      return right(UserModel);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Future<UserModelS> getCurrentUserData() async {
  //   //  var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
  //   var userData =
  //       await firestore.collection('users').doc(HiveUtils.getUserId()).get();
  //   print(HiveUtils.getUserId().toString() + '--------------');
  //   UserModelS user;
  //   if (userData.data() != null) {
  //     user = UserModelS.fromMap(userData.data()!);
  //   } else {
  //     /*Navigator.pushReplacementNamed(
  //       context,
  //       Routes.completeProfile,
  //       arguments: {
  //         "from": "login",
  //         "popToCurrent": false,
  //         "type": AuthenticationType.email,
  //         "extraData": {
  //           "firebaseUserId": "",
  //           "email": "",
  //           "username": "",
  //           "mobile": "",

  //         }
  //       },
  //     );*/
  //     throw ServerException("User Not found");
  //   }
  //   return user;
  // }

/*class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<Either<Failure, UserModelS>> signiInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final result = await auth.signInWithCredential(credential);

      UserModelS UserModelS;

      if (result.additionalUserInfo!.isNewUser) {
        UserModelS = UserModelS(
          name: result.user!.displayName ?? "",
          email: result.user!.email ?? "",
          profilePic: result.user!.photoURL ?? "",
          uid: result.user!.uid,
          phoneNumber: result.user!.phoneNumber ?? "",
          isPartner: false,
          address: "",
          userPincode: "",
          jobDetailsUpdated: "",
          kycModel: KYCModel(
            name: "",
            fatherName: '',
            motherName: '',
            aadhaarNumber: '',
            panNumber: '',
            mobileNuber: '',
            email: '',
            ifscCode: '',
            areaPincode: '',
            age: 0,
            company: '',
            accountNumber: '',
          ),
          jobSeekerProfileModel: JobSeekerProfileModel(
            name: "",
            email: "",
            jobTitle: "",
            experience: 1,
            bio: "",
            resume: "",
          ),
          companyModel: CompanyModel(
            companyName: "",
            industry: "",
            companySize: 0,
            location: "",
            companyWebsiteURL: '',
            recruiterUid: "",
          ),
        );
        await firestore
            .collection("users")
            .doc(result.user!.uid)
            .set(UserModelS.toMap());
      } else {
        UserModelS = await getCurrentUserData();
      }

      return right(UserModelS);
    } catch (e) {
      return left(
        Failure(error: e.toString()),
      );
    }
  }

  Future<UserModelS> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModelS? user;
    if (userData.data() != null) {
      user = UserModelS.fromMap(userData.data()!);
    } else {
      throw ServerException("User Not found");
    }
    return user;
  }

  Future<UserModelS?> getCurrentUserDataaaa() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModelS? user;
    if (userData.data() != null) {
      user = UserModelS.fromMap(userData.data()!);
    } else {
      throw ServerException("User Not found");
    }
    return user;
  }*/

  Future<void> signOut() async {
    return await auth.signOut();
  }

  Future<UserModelS> _handleUserCreationOrUpdate1(
      User user, bool isNewUser) async {
    UserModelS UserModel;
    if (isNewUser) {
      UserModel = UserModelS(
        name: user.displayName ?? "",
        email: user.email ?? "",
        profilePic: user.photoURL ?? "",
        uid: user.uid,
        phoneNumber: user.phoneNumber ?? "",
        isPartner: false,
        address: "",
        userPincode: "",
        jobDetailsUpdated: "",
        kycModel: KYCModel(
          name: "",
          fatherName: '',
          motherName: '',
          aadhaarNumber: '',
          panNumber: '',
          mobileNuber: '',
          email: '',
          ifscCode: '',
          areaPincode: '',
          age: 0,
          company: '',
          accountNumber: '',
        ),
        jobSeekerProfileModel: JobSeekerProfileModel(
          name: "",
          email: "",
          jobTitle: "",
          experience: 1,
          bio: "",
          resume: "",
        ),
        companyModel: CompanyModel(
          companyName: "",
          industry: "",
          companySize: 0,
          location: "",
          companyWebsiteURL: '',
          recruiterUid: "",
        ),
      );
      await firestore.collection("users").doc(user.uid).set(UserModel.toMap());
    } else {
      // UserModel = await getCurrentUserData();
    }
    return UserModel = UserModelS(
        name: 'afreed',
        email: 'm@gmail.com',
        profilePic: '',
        uid: 'uid',
        phoneNumber: '',
        address: '',
        userPincode: '',
        jobDetailsUpdated: '',
        kycModel: KYCModel(
            name: '',
            fatherName: '',
            motherName: '',
            aadhaarNumber: '',
            panNumber: '',
            mobileNuber: '',
            email: '',
            ifscCode: '',
            areaPincode: '',
            age: 10,
            company: '',
            accountNumber: ''),
        jobSeekerProfileModel: JobSeekerProfileModel(name:  '', email: 'email', jobTitle: '', experience: 1, bio: '', resume: ''),
        companyModel: CompanyModel(companyName: 'companyName', industry: 'industry', companySize: 2, location: 'location', companyWebsiteURL: 'companyWebsiteURL', recruiterUid: 'recruiterUid'),
        isPartner: false);
  }
}
