import 'dart:convert';

class CommentModel {
  final String profilePic;
  final String userName;
  final String useruid;
  final String text;
  final String commentId;
  final DateTime datePublished;
  final List<String> likes;
  CommentModel({
    required this.profilePic,
    required this.userName,
    required this.useruid,
    required this.text,
    required this.commentId,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'profilePic': profilePic});
    result.addAll({'userName': userName});
    result.addAll({'useruid': useruid});
    result.addAll({'text': text});
    result.addAll({'commentId': commentId});
    result.addAll({'datePublished': datePublished.millisecondsSinceEpoch});
    result.addAll({'likes': likes});

    return result;
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      profilePic: map['profilePic'] ?? '',
      userName: map['userName'] ?? '',
      useruid: map['useruid'] ?? '',
      text: map['text'] ?? '',
      commentId: map['commentId'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      likes: List<String>.from(map['likes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));
}
