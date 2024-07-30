import '../../auth/models/user_modelaaa.dart';

class OLXModel {
  final String title;
  final String description;
  final int prize;
  final String details;
  final List<String> imagePath;
  final DateTime createAt;
  final String userUid;
  final UserModelS userModel;

  OLXModel({
    required this.title,
    required this.description,
    required this.prize,
    required this.details,
    required this.imagePath,
    required this.createAt,
    required this.userUid,
    required this.userModel,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'prize': prize});
    result.addAll({'details': details});
    result.addAll({'imagePath': imagePath});
    result.addAll({'createAt': createAt.millisecondsSinceEpoch});
    result.addAll({'userUid': userUid});
    result.addAll({'userModel': userModel.toMap()});

    return result;
  }

  factory OLXModel.fromMap(Map<String, dynamic> map) {
    return OLXModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      prize: map['prize']?.toInt() ?? 0,
      details: map['details'] ?? '',
      imagePath: List<String>.from(map['imagePath']),
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt']),
      userUid: map['userUid'] ?? '',
      userModel: UserModelS.fromMap(map['userModel']),
    );
  }
}
