import 'dart:convert';

import '../../auth/models/user_modelaaa.dart';





class JobModel {
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final bool isRemote;
  final String uid;
  final int experience;
  final int salary;
  final String education;
  final UserModelS userModel;
  final DateTime dateCreated;
  final String id;
  final String perTime;

  JobModel({
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    required this.isRemote,
    required this.uid,
    required this.experience,
    required this.salary,
    required this.education,
    required this.userModel,
    required this.dateCreated,
    required this.id,
    required this.perTime,
  });

  JobModel copyWith({
    String? jobTitle,
    String? jobDescription,
    String? jobLocation,
    bool? isRemote,
    String? uid,
    int? experience,
    int? salary,
    String? education,
    UserModelS? userModel,
    DateTime? dateCreated,
    String? id,
    String? perTime,
  }) {
    return JobModel(
      jobTitle: jobTitle ?? this.jobTitle,
      jobDescription: jobDescription ?? this.jobDescription,
      jobLocation: jobLocation ?? this.jobLocation,
      isRemote: isRemote ?? this.isRemote,
      uid: uid ?? this.uid,
      experience: experience ?? this.experience,
      salary: salary ?? this.salary,
      education: education ?? this.education,
      userModel: userModel ?? this.userModel,
      dateCreated: dateCreated ?? this.dateCreated,
      id: id ?? this.id,
      perTime: perTime ?? this.perTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'jobTitle': jobTitle});
    result.addAll({'jobDescription': jobDescription});
    result.addAll({'jobLocation': jobLocation});
    result.addAll({'isRemote': isRemote});
    result.addAll({'uid': uid});
    result.addAll({'experience': experience});
    result.addAll({'salary': salary});
    result.addAll({'education': education});
    result.addAll({'userModel': userModel.toMap()});
    result.addAll({'dateCreated': dateCreated.millisecondsSinceEpoch});
    result.addAll({'id': id});
    result.addAll({'perTime': perTime});

    return result;
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      jobTitle: map['jobTitle'] ?? '',
      jobDescription: map['jobDescription'] ?? '',
      jobLocation: map['jobLocation'] ?? '',
      isRemote: map['isRemote'] ?? false,
      uid: map['uid'] ?? '',
      experience: map['experience']?.toInt() ?? 0,
      salary: map['salary']?.toInt() ?? 0,
      education: map['education'] ?? '',
      userModel: UserModelS.fromMap(map['userModel']),
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      id: map['id'] ?? '',
      perTime: map['perTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JobModel(jobTitle: $jobTitle, jobDescription: $jobDescription, jobLocation: $jobLocation, isRemote: $isRemote, uid: $uid, experience: $experience, salary: $salary, education: $education, userModel: $userModel, dateCreated: $dateCreated, id: $id, perTime: $perTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JobModel &&
        other.jobTitle == jobTitle &&
        other.jobDescription == jobDescription &&
        other.jobLocation == jobLocation &&
        other.isRemote == isRemote &&
        other.uid == uid &&
        other.experience == experience &&
        other.salary == salary &&
        other.education == education &&
        other.userModel == userModel &&
        other.dateCreated == dateCreated &&
        other.id == id &&
        other.perTime == perTime;
  }

  @override
  int get hashCode {
    return jobTitle.hashCode ^
        jobDescription.hashCode ^
        jobLocation.hashCode ^
        isRemote.hashCode ^
        uid.hashCode ^
        experience.hashCode ^
        salary.hashCode ^
        education.hashCode ^
        userModel.hashCode ^
        dateCreated.hashCode ^
        id.hashCode ^
        perTime.hashCode;
  }
}
