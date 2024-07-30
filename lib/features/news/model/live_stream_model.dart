import 'dart:convert';

class LiveStreamModel {
  final String title;
  final String image;
  final String uid;
  final String username;
  final DateTime startedAt;
  final int viewers;
  final String channelId;

  LiveStreamModel({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.startedAt,
    required this.viewers,
    required this.channelId,
  });

  LiveStreamModel copyWith({
    String? title,
    String? image,
    String? uid,
    String? username,
    DateTime? startedAt,
    int? viewers,
    String? channelId,
  }) {
    return LiveStreamModel(
      title: title ?? this.title,
      image: image ?? this.image,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      startedAt: startedAt ?? this.startedAt,
      viewers: viewers ?? this.viewers,
      channelId: channelId ?? this.channelId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'uid': uid});
    result.addAll({'username': username});
    result.addAll({'startedAt': startedAt.millisecondsSinceEpoch});
    result.addAll({'viewers': viewers});
    result.addAll({'channelId': channelId});

    return result;
  }

  factory LiveStreamModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      startedAt: DateTime.fromMillisecondsSinceEpoch(map['startedAt']),
      viewers: map['viewers']?.toInt() ?? 0,
      channelId: map['channelId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveStreamModel.fromJson(String source) =>
      LiveStreamModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LiveStreamModel(title: $title, image: $image, uid: $uid, username: $username, startedAt: $startedAt, viewers: $viewers, channelId: $channelId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveStreamModel &&
        other.title == title &&
        other.image == image &&
        other.uid == uid &&
        other.username == username &&
        other.startedAt == startedAt &&
        other.viewers == viewers &&
        other.channelId == channelId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        image.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        startedAt.hashCode ^
        viewers.hashCode ^
        channelId.hashCode;
  }
}
