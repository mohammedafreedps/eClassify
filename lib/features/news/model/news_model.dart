import '../../auth/models/user_modelaaa.dart';

class NewsModel {
  final UserModelS userModel;
  final String title;
  final String description;
  final String image;
  final DateTime publishedAt;
  final String userAddress;
  final String userPincode;
  final bool isSports;
  NewsModel({
    required this.userModel,
    required this.title,
    required this.description,
    required this.image,
    required this.publishedAt,
    required this.userAddress,
    required this.userPincode,
    required this.isSports,
  });

  NewsModel copyWith({
    UserModelS? userModel,
    String? title,
    String? description,
    String? image,
    DateTime? publishedAt,
    String? userAddress,
    String? userPincode,
    bool? isSports,
  }) {
    return NewsModel(
      userModel: userModel ?? this.userModel,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      publishedAt: publishedAt ?? this.publishedAt,
      userAddress: userAddress ?? this.userAddress,
      userPincode: userPincode ?? this.userPincode,
      isSports: isSports ?? this.isSports,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userModel': userModel.toMap()});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
    result.addAll({'publishedAt': publishedAt.millisecondsSinceEpoch});
    result.addAll({'userAddress': userAddress});
    result.addAll({'userPincode': userPincode});
    result.addAll({'isSports': isSports});

    return result;
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      userModel: UserModelS.fromMap(map['userModel']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      publishedAt: DateTime.fromMillisecondsSinceEpoch(map['publishedAt']),
      userAddress: map['userAddress'] ?? '',
      userPincode: map['userPincode'] ?? '',
      isSports: map['isSports'] ?? false,
    );
  }
}
