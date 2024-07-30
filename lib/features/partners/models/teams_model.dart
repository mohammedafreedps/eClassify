// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeamsModel {
  final String name;
  final String email;
  final DateTime dateCreated;
  final int number;
  final String id;
  final String department;
  final String uid;

  TeamsModel({
    required this.name,
    required this.email,
    required this.dateCreated,
    required this.number,
    required this.id,
    required this.department,
    required this.uid,
  });

  TeamsModel copyWith({
    String? name,
    String? email,
    DateTime? dateCreated,
    int? number,
    String? id,
    String? department,
    String? uid,
  }) {
    return TeamsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      dateCreated: dateCreated ?? this.dateCreated,
      number: number ?? this.number,
      id: id ?? this.id,
      department: department ?? this.department,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'number': number,
      'id': id,
      'department': department,
      'uid': uid,
    };
  }

  factory TeamsModel.fromMap(Map<String, dynamic> map) {
    return TeamsModel(
      name: map['name'] as String,
      email: map['email'] as String,
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
      number: map['number'] as int,
      id: map['id'] as String,
      department: map['department'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamsModel.fromJson(String source) =>
      TeamsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeamsModel(name: $name, email: $email, dateCreated: $dateCreated, number: $number, id: $id, department: $department, uid: $uid)';
  }

  @override
  bool operator ==(covariant TeamsModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.dateCreated == dateCreated &&
        other.number == number &&
        other.id == id &&
        other.department == department &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        dateCreated.hashCode ^
        number.hashCode ^
        id.hashCode ^
        department.hashCode ^
        uid.hashCode;
  }
}
