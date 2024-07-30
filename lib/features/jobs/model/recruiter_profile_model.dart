import 'dart:convert';

class RecruiterProfileModel {
  final String fullName;
  final String jobPosition;
  final String email;
  final String recruiterUid;

  RecruiterProfileModel({
    required this.fullName,
    required this.jobPosition,
    required this.email,
    required this.recruiterUid,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'fullName': fullName});
    result.addAll({'jobPosition': jobPosition});
    result.addAll({'email': email});
    result.addAll({'recruiterUid': recruiterUid});

    return result;
  }

  factory RecruiterProfileModel.fromMap(Map<String, dynamic> map) {
    return RecruiterProfileModel(
      fullName: map['fullName'] ?? '',
      jobPosition: map['jobPosition'] ?? '',
      email: map['email'] ?? '',
      recruiterUid: map['recruiterUid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RecruiterProfileModel.fromJson(String source) =>
      RecruiterProfileModel.fromMap(json.decode(source));
}
