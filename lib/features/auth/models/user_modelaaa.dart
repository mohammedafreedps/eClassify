// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../jobs/model/company_model.dart';
import '../../jobs/model/job_seeker_profile_model.dart';
import '../../kyc/model/kyc_model.dart';

class UserModelS {
  final String name;
  final String email;
  final String profilePic;
  final String uid;
  final String? phoneNumber;
  final String? address;
  final String? userPincode;
  final String? jobDetailsUpdated;
  final KYCModel? kycModel;
  final JobSeekerProfileModel jobSeekerProfileModel;
  final CompanyModel companyModel;
  final bool isPartner;

  UserModelS({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.phoneNumber,
    required this.address,
    required this.userPincode,
    required this.jobDetailsUpdated,
    required this.kycModel,
    required this.jobSeekerProfileModel,
    required this.companyModel,
    required this.isPartner,
  });

  UserModelS copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? uid,
    String? phoneNumber,
    String? address,
    String? userPincode,
    String? jobDetailsUpdated,
    KYCModel? kycModel,
    JobSeekerProfileModel? jobSeekerProfileModel,
    CompanyModel? companyModel,
    bool? isPartner,
  }) {
    return UserModelS(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      userPincode: userPincode ?? this.userPincode,
      jobDetailsUpdated: jobDetailsUpdated ?? this.jobDetailsUpdated,
      kycModel: kycModel ?? this.kycModel,
      jobSeekerProfileModel:
          jobSeekerProfileModel ?? this.jobSeekerProfileModel,
      companyModel: companyModel ?? this.companyModel,
      isPartner: isPartner ?? this.isPartner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'address': address,
      'userPincode': userPincode,
      'jobDetailsUpdated': jobDetailsUpdated,
      'kycModel': kycModel?.toMap(),
      'jobSeekerProfileModel': jobSeekerProfileModel.toMap(),
      'companyModel': companyModel.toMap(),
      'isPartner': isPartner,
    };
  }

  factory UserModelS.fromMap(Map<String, dynamic> map) {
    print("Map data: $map");
    print("Address in map: ${map['address']}");
    return UserModelS(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      userPincode:
          map['userPincode'] != null ? map['userPincode'] as String : null,
      jobDetailsUpdated: map['jobDetailsUpdated'] != null
          ? map['jobDetailsUpdated'] as String
          : null,
      kycModel: map['kycModel'] != null
          ? KYCModel.fromMap(map['kycModel'] as Map<String, dynamic>)
          : null,
      jobSeekerProfileModel: JobSeekerProfileModel.fromMap(
          map['jobSeekerProfileModel'] as Map<String, dynamic>),
      companyModel:
          CompanyModel.fromMap(map['companyModel'] as Map<String, dynamic>),
      isPartner: map['isPartner'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelS.fromJson(String source) =>
      UserModelS.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid, phoneNumber: $phoneNumber, address: $address, userPincode: $userPincode, jobDetailsUpdated: $jobDetailsUpdated, kycModel: $kycModel, jobSeekerProfileModel: $jobSeekerProfileModel, companyModel: $companyModel, isPartner: $isPartner)';
  }

  @override
  bool operator ==(covariant UserModelS other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.userPincode == userPincode &&
        other.jobDetailsUpdated == jobDetailsUpdated &&
        other.kycModel == kycModel &&
        other.jobSeekerProfileModel == jobSeekerProfileModel &&
        other.companyModel == companyModel &&
        other.isPartner == isPartner;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        userPincode.hashCode ^
        jobDetailsUpdated.hashCode ^
        kycModel.hashCode ^
        jobSeekerProfileModel.hashCode ^
        companyModel.hashCode ^
        isPartner.hashCode;
  }
}
