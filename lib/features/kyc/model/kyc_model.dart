import 'dart:convert';

class KYCModel {
  final String name;
  final String fatherName;
  final String motherName;
  final String aadhaarNumber;
  final String panNumber;
  final String mobileNuber;
  final String email;
  final String ifscCode;
  final String areaPincode;
  final int age;
  final String company;
  final String accountNumber;

  KYCModel({
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.aadhaarNumber,
    required this.panNumber,
    required this.mobileNuber,
    required this.email,
    required this.ifscCode,
    required this.areaPincode,
    required this.age,
    required this.company,
    required this.accountNumber,
  });

  KYCModel copyWith({
    String? name,
    String? fatherName,
    String? motherName,
    String? aadhaarNumber,
    String? panNumber,
    String? mobileNuber,
    String? email,
    String? ifscCode,
    String? areaPincode,
    int? age,
    String? company,
    String? accountNumber,
  }) {
    return KYCModel(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      panNumber: panNumber ?? this.panNumber,
      mobileNuber: mobileNuber ?? this.mobileNuber,
      email: email ?? this.email,
      ifscCode: ifscCode ?? this.ifscCode,
      areaPincode: areaPincode ?? this.areaPincode,
      age: age ?? this.age,
      company: company ?? this.company,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'fatherName': fatherName});
    result.addAll({'motherName': motherName});
    result.addAll({'aadhaarNumber': aadhaarNumber});
    result.addAll({'panNumber': panNumber});
    result.addAll({'mobileNuber': mobileNuber});
    result.addAll({'email': email});
    result.addAll({'ifscCode': ifscCode});
    result.addAll({'areaPincode': areaPincode});
    result.addAll({'age': age});
    result.addAll({'company': company});
    result.addAll({'accountNumber': accountNumber});

    return result;
  }

  factory KYCModel.fromMap(Map<String, dynamic> map) {
    return KYCModel(
      name: map['name'] ?? '',
      fatherName: map['fatherName'] ?? '',
      motherName: map['motherName'] ?? '',
      aadhaarNumber: map['aadhaarNumber'] ?? '',
      panNumber: map['panNumber'] ?? '',
      mobileNuber: map['mobileNuber'] ?? '',
      email: map['email'] ?? '',
      ifscCode: map['ifscCode'] ?? '',
      areaPincode: map['areaPincode'] ?? '',
      age: map['age']?.toInt() ?? 0,
      company: map['company'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KYCModel.fromJson(String source) =>
      KYCModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KYCModel(name: $name, fatherName: $fatherName, motherName: $motherName, aadhaarNumber: $aadhaarNumber, panNumber: $panNumber, mobileNuber: $mobileNuber, email: $email, ifscCode: $ifscCode, areaPincode: $areaPincode, age: $age, company: $company, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KYCModel &&
        other.name == name &&
        other.fatherName == fatherName &&
        other.motherName == motherName &&
        other.aadhaarNumber == aadhaarNumber &&
        other.panNumber == panNumber &&
        other.mobileNuber == mobileNuber &&
        other.email == email &&
        other.ifscCode == ifscCode &&
        other.areaPincode == areaPincode &&
        other.age == age &&
        other.company == company &&
        other.accountNumber == accountNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        fatherName.hashCode ^
        motherName.hashCode ^
        aadhaarNumber.hashCode ^
        panNumber.hashCode ^
        mobileNuber.hashCode ^
        email.hashCode ^
        ifscCode.hashCode ^
        areaPincode.hashCode ^
        age.hashCode ^
        company.hashCode ^
        accountNumber.hashCode;
  }
}
