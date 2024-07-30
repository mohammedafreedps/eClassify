class JobSeekerProfileModel {
  final String name;
  final String email;
  final String jobTitle;
  final int experience;
  final String bio;
  final String resume;

  JobSeekerProfileModel({
    required this.name,
    required this.email,
    required this.jobTitle,
    required this.experience,
    required this.bio,
    required this.resume,
  });

  JobSeekerProfileModel copyWith({
    String? name,
    String? email,
    String? jobTitle,
    int? experience,
    String? bio,
    String? resume,
  }) {
    return JobSeekerProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      jobTitle: jobTitle ?? this.jobTitle,
      experience: experience ?? this.experience,
      bio: bio ?? this.bio,
      resume: resume ?? this.resume,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'jobTitle': jobTitle});
    result.addAll({'experience': experience});
    result.addAll({'bio': bio});
    result.addAll({'resume': resume});

    return result;
  }

  factory JobSeekerProfileModel.fromMap(Map<String, dynamic> map) {
    return JobSeekerProfileModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      experience: map['experience'] ?? 0,
      bio: map['bio'] ?? '',
      resume: map['resume'] ?? '',
    );
  }
}
