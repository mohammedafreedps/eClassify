import 'dart:convert';

import '../../auth/models/user_modelaaa.dart';


class StreamingModel {
  final String title;
  final String desc;
  final String imagePath;
  final String videoPath;
  final DateTime createdAt;
  final UserModelS userModel;

  StreamingModel({
    required this.title,
    required this.desc,
    required this.imagePath,
    required this.videoPath,
    required this.createdAt,
    required this.userModel,
  });

  StreamingModel copyWith({
    String? title,
    String? desc,
    String? imagePath,
    String? videoPath,
    DateTime? createdAt,
    UserModelS? userModel,
  }) {
    return StreamingModel(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      imagePath: imagePath ?? this.imagePath,
      videoPath: videoPath ?? this.videoPath,
      createdAt: createdAt ?? this.createdAt,
      userModel: userModel ?? this.userModel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'desc': desc});
    result.addAll({'imagePath': imagePath});
    result.addAll({'videoPath': videoPath});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'userModel': userModel.toMap()});

    return result;
  }

  factory StreamingModel.fromMap(Map<String, dynamic> map) {
    return StreamingModel(
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      imagePath: map['imagePath'] ?? '',
      videoPath: map['videoPath'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      userModel: UserModelS.fromMap(map['userModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StreamingModel.fromJson(String source) =>
      StreamingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StreamingModel(title: $title, desc: $desc, imagePath: $imagePath, videoPath: $videoPath, createdAt: $createdAt, userModel: $userModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StreamingModel &&
        other.title == title &&
        other.desc == desc &&
        other.imagePath == imagePath &&
        other.videoPath == videoPath &&
        other.createdAt == createdAt &&
        other.userModel == userModel;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        imagePath.hashCode ^
        videoPath.hashCode ^
        createdAt.hashCode ^
        userModel.hashCode;
  }
}
