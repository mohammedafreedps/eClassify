import 'dart:convert';

class CompanyModel {
  final String companyName;
  final String industry;
  final int companySize;
  final String location;
  final String companyWebsiteURL;
  final String recruiterUid;
  CompanyModel({
    required this.companyName,
    required this.industry,
    required this.companySize,
    required this.location,
    required this.companyWebsiteURL,
    required this.recruiterUid,
  });

  CompanyModel copyWith({
    String? companyName,
    String? industry,
    int? companySize,
    String? location,
    String? companyWebsiteURL,
    String? recruiterUid,
  }) {
    return CompanyModel(
      companyName: companyName ?? this.companyName,
      industry: industry ?? this.industry,
      companySize: companySize ?? this.companySize,
      location: location ?? this.location,
      companyWebsiteURL: companyWebsiteURL ?? this.companyWebsiteURL,
      recruiterUid: recruiterUid ?? this.recruiterUid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'companyName': companyName});
    result.addAll({'industry': industry});
    result.addAll({'companySize': companySize});
    result.addAll({'location': location});
    result.addAll({'companyWebsiteURL': companyWebsiteURL});
    result.addAll({'recruiterUid': recruiterUid});

    return result;
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      companyName: map['companyName'] ?? '',
      industry: map['industry'] ?? '',
      companySize: map['companySize']?.toInt() ?? 0,
      location: map['location'] ?? '',
      companyWebsiteURL: map['companyWebsiteURL'] ?? '',
      recruiterUid: map['recruiterUid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyModel(companyName: $companyName, industry: $industry, companySize: $companySize, location: $location, companyWebsiteURL: $companyWebsiteURL, recruiterUid: $recruiterUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyModel &&
        other.companyName == companyName &&
        other.industry == industry &&
        other.companySize == companySize &&
        other.location == location &&
        other.companyWebsiteURL == companyWebsiteURL &&
        other.recruiterUid == recruiterUid;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        industry.hashCode ^
        companySize.hashCode ^
        location.hashCode ^
        companyWebsiteURL.hashCode ^
        recruiterUid.hashCode;
  }
}
